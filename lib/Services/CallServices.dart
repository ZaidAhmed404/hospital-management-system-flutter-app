import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Widgets/MessageWidget.dart';

class CallServices {
  CollectionReference callLog =
      FirebaseFirestore.instance.collection('callLogs');

  Future<bool> addCallRecord({
    required String callerId,
    required String callerName,
    required String callerPhotoUrl,
    required String targetUserId,
    required String targetUserName,
    required String targetUserPhotoUrl,
    required String callType,
  }) async {
    try {
      final now = DateTime.now();
      await callLog
          .add({
            "callerId": callerId,
            "callerName": callerName,
            "callerPhotoUrl": callerPhotoUrl,
            "targetUserId": targetUserId,
            "targetUserName": targetUserName,
            "targetUserPhotoUrl": targetUserPhotoUrl,
            "callType": callType,
            "time":
                "${TimeOfDay.now().hour % 12 == 0 ? 12 : TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute}:${TimeOfDay.now().period.name}",
            "date": "${now.day}-${now.month}-${now.year}"
          })
          .then((value) => log("Call Log data Added", name: "success"))
          .catchError((error) =>
              log("Failed to add Call Log data: $error", name: "error"));
    } catch (error) {
      return false;
    }

    return true;
  }
}
