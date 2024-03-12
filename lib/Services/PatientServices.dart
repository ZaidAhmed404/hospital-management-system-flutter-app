import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/cubit/patient/patient_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/PatientModel.dart';
import '../Widgets/MessageWidget.dart';
import '../cubit/LoadingCubit/loading_cubit.dart';
import '../cubit/UserCubit/user_cubit.dart';

class PatientServices {
  CollectionReference patient =
      FirebaseFirestore.instance.collection('patients');

  Future updatePatientData({
    required BuildContext context,
    required String photoPath,
    required String name,
    required String phoneNumber,
    required String cnic,
    required String address,
    required String gender,
  }) async {
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

      patient
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({
            'cnic': cnic,
            'address': address,
            'phoneNumber': phoneNumber,
          })
          .then((value) => log("User Added"))
          .catchError((error) => log("Failed to add user: $error"));
      if (context.mounted) {
        BlocProvider.of<PatientCubit>(context).updatePatientModel(
            singlePatientModel: PatientModel(
          address: address,
          cnic: cnic,
          phoneNumber: phoneNumber,
          gender: gender,
        ));
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
}
