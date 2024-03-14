import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/DoctorModel.dart';
import '../Widgets/MessageWidget.dart';
import '../cubit/DoctorCubit/doctor_cubit.dart';
import '../cubit/LoadingCubit/loading_cubit.dart';
import '../cubit/UserCubit/user_cubit.dart';

class DoctorServices {
  CollectionReference doctor = FirebaseFirestore.instance.collection('doctors');

  Future updateDoctorData(
      {required BuildContext context,
      required String photoPath,
      required String name,
      required String phoneNumber,
      required String cnic,
      required String address,
      required String gender,
      required String licenseNumber,
      required String specialization,
      required String cardNumber,
      required String hourlyRate}) async {
    BlocProvider.of<LoadingCubit>(context).setLoading(true);
    FocusScope.of(context).unfocus();
    try {
      if (photoPath != "") {
        final file = File(photoPath);
        final metadata = SettableMetadata(contentType: "image/jpeg");

        final storageRef = FirebaseStorage.instance.ref();
        final uploadTask = storageRef
            .child("profile images/${FirebaseAuth.instance.currentUser?.uid}")
            .putFile(file, metadata);
        final snapshot = await uploadTask.whenComplete(() => null);

        String url = await snapshot.ref.getDownloadURL();
        await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
        if (context.mounted) {
          BlocProvider.of<UserCubit>(context).updatePhotoUrl(url);
        }
      }
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      if (context.mounted) {
        BlocProvider.of<UserCubit>(context).updateDisplayName(name);
      }

      doctor
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
            "name": FirebaseAuth.instance.currentUser?.displayName,
            "photoUrl": FirebaseAuth.instance.currentUser?.photoURL,
            'cnic': cnic,
            'address': address,
            'phoneNumber': phoneNumber,
            "licenseNumber": licenseNumber,
            "specialization": specialization,
            'cardNumber': cardNumber,
            'hourlyRate': hourlyRate
          })
          .then((value) => log("User Added"))
          .catchError((error) => log("Failed to add user: $error"));
      if (context.mounted) {
        BlocProvider.of<DoctorCubit>(context).updateDoctorModel(
            singleDoctorModel: DoctorModel(
                userId: FirebaseAuth.instance.currentUser?.uid ?? "",
                address: address,
                name: FirebaseAuth.instance.currentUser?.displayName ?? "",
                photoUrl: FirebaseAuth.instance.currentUser?.photoURL ?? "",
                cnic: cnic,
                phoneNumber: phoneNumber,
                gender: gender,
                licenseNumber: licenseNumber,
                specialization: specialization,
                hourlyRate: hourlyRate,
                cardNumber: cardNumber));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: e.message.toString());
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: "Something went wrong");
      }
      log("$error", name: "error updating user");
    }
    if (context.mounted) {
      messageWidget(
          context: context,
          isError: false,
          message: "Profile Updated Successfully");
    }
    if (context.mounted) {
      BlocProvider.of<LoadingCubit>(context).setLoading(false);
    }
  }

  updateProfileStatus(
      {required String docId,
      required BuildContext context,
      required String status}) async {
    try {
      await doctor.doc(docId).update({"profileState": "approved"});
      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message: "Profile Approved Successfully");
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }
  }
}
