import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Widgets/MessageWidget.dart';

class MedicineServices {
  Future add(
      {required String name,
      required String pharmacyId,
      required String quantity,
      required BuildContext context}) async {
    CollectionReference medicine =
        FirebaseFirestore.instance.collection('$pharmacyId.medicine');
    try {
      final now = DateTime.now();
      await medicine
          .add({
            "name": name,
            "quantity": quantity,
            "date": "${now.day}-${now.month}-${now.year}"
          })
          .then((value) => log("Medicine data Added", name: "success"))
          .catchError((error) =>
              log("Failed to add Medicine data: $error", name: "error"));
      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message: "Medicine Added Successfully");
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

  Future update(
      {required String docId,
      required String name,
      required String quantity,
      required String pharmacyId,
      required BuildContext context}) async {
    CollectionReference medicine =
        FirebaseFirestore.instance.collection('$pharmacyId.medicine');

    try {
      final now = DateTime.now();
      await medicine
          .doc(docId)
          .update({
            "name": name,
            "quantity": quantity,
            "date": "${now.day}-${now.month}-${now.year}"
          })
          .then((value) => log("Medicine data Updated", name: "success"))
          .catchError((error) =>
              log("Failed to updating Medicine data: $error", name: "error"));
      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message: "Medicine Updated Successfully");
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

  Future delete(
      {required String docId,
      required BuildContext context,
      required String pharmacyId}) async {
    CollectionReference medicine =
        FirebaseFirestore.instance.collection('$pharmacyId.medicine');

    try {
      await medicine
          .doc(docId)
          .delete()
          .then((value) => log("Medicine data Deleted", name: "success"))
          .catchError((error) =>
              log("Failed to deleting Medicine data: $error", name: "error"));
      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message: "Medicine Deleted Successfully");
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }
  }
}
