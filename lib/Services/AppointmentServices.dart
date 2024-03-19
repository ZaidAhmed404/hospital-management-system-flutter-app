import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/MessageWidget.dart';
import '../cubit/LoadingCubit/loading_cubit.dart';

class AppointmentServices {
  TimeOfDay addMinutesToTime(TimeOfDay time, int minutesToAdd) {
    int totalMinutes = time.hour * 60 + time.minute + minutesToAdd;
    int newHour = totalMinutes ~/ 60;
    int newMinute = totalMinutes % 60;
    return TimeOfDay(hour: newHour % 24, minute: newMinute);
  }

  CollectionReference appointment =
      FirebaseFirestore.instance.collection('appointments');

  Future<bool> addAppointment(
      {required String name,
      required DateTime date,
      required String slot,
      required TimeOfDay time,
      required String description,
      required String doctorId,
      required String doctorName,
      required String doctorPhotoUrl,
      required BuildContext context}) async {
    BlocProvider.of<LoadingCubit>(context).setLoading(true);
    FocusScope.of(context).unfocus();

    try {
      final now = DateTime.now();
      await appointment
          .add({
            "name": name,
            "description": description,
            "timeSlot": slot,
            "patientId": "${FirebaseAuth.instance.currentUser?.uid}",
            "patientName": "${FirebaseAuth.instance.currentUser?.displayName}",
            "patientPhotoUrl": "${FirebaseAuth.instance.currentUser?.photoURL}",
            "doctorId": doctorId,
            "doctorName": doctorName,
            "doctorPhotoUrl": doctorPhotoUrl,
            "startTime":
                "${time.hour % 12 == 0 ? 12 : time.hour % 12}:${time.minute} ${time.period.name}",
            "endTime": slot == "30 Minutes"
                ? "${time.hour % 12 == 0 ? 12 : addMinutesToTime(time, 30).hour % 12}:${addMinutesToTime(time, 30).minute} ${time.period.name}"
                : "${time.hour % 12 == 0 ? 12 : addMinutesToTime(time, 60).hour % 12}:${addMinutesToTime(time, 60).minute} ${time.period.name}",
            "appointmentDate": "${date.day}-${date.month}-${date.year}",
            "date": "${now.day}-${now.month}-${now.year}"
          })
          .then((value) => log("Appointment data Added", name: "success"))
          .catchError((error) =>
              log("Failed to add Appointment data: $error", name: "error"));
      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message: "Appointment Added Successfully");
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
      return false;
    }
    if (context.mounted) {
      BlocProvider.of<LoadingCubit>(context).setLoading(false);
    }
    return true;
  }
}
