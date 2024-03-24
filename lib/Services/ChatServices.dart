import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';
import '../Widgets/MessageWidget.dart';

class ChatServices {
  sendMessage(
      {required String patientId,
      required String patientName,
      required String patientPhotoUrl,
      required String doctorName,
      required String doctorPhotoUrl,
      required String doctorId,
      required String message,
      required String appointmentId,
      required BuildContext context}) async {
    CollectionReference chat = FirebaseFirestore.instance
        .collection('chat.$patientId.$doctorId.$appointmentId');
    final now = DateTime.now();
    try {
      await chat
          .add({
            "patientId": patientId,
            "patientName": patientName,
            "patientPhotoUrl": patientPhotoUrl,
            "doctorId": doctorId,
            "doctorName": doctorName,
            "doctorPhotoUrl": doctorPhotoUrl,
            "date": "${now.day}-${now.month}-${now.year}",
            "message": message,
            "time":
                "${TimeOfDay.now().hour % 12 == 0 ? 12 : TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute} ${TimeOfDay.now().period.name}",
            "sendBy": appConstants.role
          })
          .then((value) => log("Message Sent", name: "success"))
          .catchError(
              (error) => log("Failed to Sent message: $error", name: "error"));
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }
  }
}
