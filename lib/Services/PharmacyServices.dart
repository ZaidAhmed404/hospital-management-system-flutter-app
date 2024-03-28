import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/MessageWidget.dart';

class PharmacyServices {
  CollectionReference pharmacy =
      FirebaseFirestore.instance.collection('pharmacies');
  CollectionReference owner =
      FirebaseFirestore.instance.collection('pharmacyOwners');

  addPharmacy(
      {required String ownerName,
      required String userEmail,
      required String password,
      required String pharmacyName,
      required String pharmacyAddress,
      required BuildContext context}) async {
    final now = DateTime.now();
    FocusScope.of(context).unfocus();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: password,
      );
      log(userCredential.user!.uid, name: "user Id");
      await owner.doc(userCredential.user!.uid).set({
        "ownerName": ownerName,
        "ownerId": userCredential.user!.uid,
      });
      await pharmacy
          .doc(userCredential.user!.uid)
          .set({
            "ownerName": ownerName,
            "ownerId": userCredential.user!.uid,
            "name": pharmacyName,
            "address": pharmacyAddress,
            "date": "${now.day}-${now.month}-${now.year}"
          })
          .then((value) => log("Pharmacy Added Successfully", name: "success"))
          .catchError(
              (error) => log("Failed to add Pharmacy: $error", name: "error"));

      if (context.mounted) {
        Navigator.pop(context);
        messageWidget(
            context: context,
            isError: false,
            message: "Pharmacy Added Successfully");
      }
    } catch (error) {
      if (context.mounted) {
        Navigator.pop(context);
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }
  }

  Future update(
      {required String docId,
      required String name,
      required String address,
      required BuildContext context}) async {
    try {
      final now = DateTime.now();
      await pharmacy
          .doc(docId)
          .update({
            "name": name,
            "address": address,
            "date": "${now.day}-${now.month}-${now.year}"
          })
          .then((value) => log("Pharmacy data Updated", name: "success"))
          .catchError((error) =>
              log("Failed to updating Pharmacy data: $error", name: "error"));
      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message: "Pharmacy Updated Successfully");
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  Future delete({required String docId, required BuildContext context}) async {
    try {
      await pharmacy
          .doc(docId)
          .delete()
          .then((value) => log("Pharmacy data Deleted", name: "success"))
          .catchError((error) =>
              log("Failed to deleting Pharmacy data: $error", name: "error"));
      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message: "Pharmacy Deleted Successfully");
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }
  }
}
