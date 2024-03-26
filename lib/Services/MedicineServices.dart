import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../Widgets/MessageWidget.dart';

class MedicineServices {
  CollectionReference orderMedicines =
      FirebaseFirestore.instance.collection('orderMedicines');

  Future add(
      {required String name,
      required String pharmacyId,
      required String quantity,
      required String price,
      required BuildContext context}) async {
    CollectionReference medicine =
        FirebaseFirestore.instance.collection('$pharmacyId.medicine');
    try {
      final now = DateTime.now();
      await medicine
          .add({
            "name": name,
            "quantity": quantity,
            "price": price,
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
      required String price,
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
            "price": price,
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

  Future orderMedicine({
    required String name,
    required List<Map> medicines,
    required String address,
    required String ownerId,
    required String total,
    required BuildContext context,
  }) async {
    try {
      final now = DateTime.now();
      await orderMedicines
          .add({
            "name": name,
            "userId": FirebaseAuth.instance.currentUser!.uid,
            "medicines": medicines,
            "address": address,
            "ownerId": ownerId,
            "total": total,
            "status": "pending",
            "date": "${now.day}-${now.month}-${now.year}"
          })
          .then((value) => log("Order Added", name: "success"))
          .catchError((error) =>
              log("Failed to add Order data: $error", name: "error"));
      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message: "Order Placed Successfully");
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }
  }

  Future changeStatus(
      {required String status,
      required String docId,
      required String ticketNumber,
      required BuildContext context}) async {
    try {
      await orderMedicines
          .doc(docId)
          .update({"status": status, "ticketNumber": ticketNumber});
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }
  }
}
