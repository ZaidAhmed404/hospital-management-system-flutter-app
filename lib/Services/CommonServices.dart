import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../Models/DoctorModel.dart';
import '../Models/PatientModel.dart';
import '../Route/CustomPageRoute.dart';
import '../Screens/AdminLandingScreen/AdminLandingScreen.dart';
import '../Screens/BoardingScreen/BoardingScreen.dart';
import '../Screens/LandingScreen/LandingScreen.dart';
import '../Screens/PharmacyOwnerLandingScreen/PharmacyOwnerLandingScreen.dart';
import '../Screens/ProfileNotApprovedScreen/ProfileNotApprovedScreen.dart';
import '../Screens/RegisterUserRoleScreen/RegisterUserRolesScreen.dart';
import '../Widgets/MessageWidget.dart';
import '../cubit/DoctorCubit/doctor_cubit.dart';
import '../cubit/UserCubit/user_cubit.dart';
import '../cubit/patient/patient_cubit.dart';

class CommonServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future initializeSetting({required BuildContext context}) async {
    Map<String, dynamic> data = {};
    bool gotCollectionData = false;

    String doctorProfileStatus = "";
    if (auth.currentUser != null) {
      try {
        final QuerySnapshot snapshot =
            await FirebaseFirestore.instance.collection('pharmacyOwners').get();

        snapshot.docs.map((DocumentSnapshot doc) {
          Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
          if (auth.currentUser!.uid == data['ownerId']) {
            Navigator.pushAndRemoveUntil(
              context,
              CustomPageRoute(child: PharmacyOwnerLandingScreen()),
              (route) => false,
            );
            return;
          }
        }).toList();
      } catch (_) {}
    }

    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(auth.currentUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        log("${documentSnapshot.data()}", name: "doctor data");
        if (documentSnapshot.exists) {
          data = documentSnapshot.data() as Map<String, dynamic>;
        }
      }
      if (data.isNotEmpty) {
        if (context.mounted) {
          gotCollectionData = true;
          appConstants.role = "doctor";
          if (data['profileState'] == "approved") {
            doctorProfileStatus = "approved";
          }
          BlocProvider.of<DoctorCubit>(context)
              .updateDoctorModel(singleDoctorModel: DoctorModel.fromMap(data));
        }
      }
    } catch (error) {
      // if (context.mounted) {
      //   messageWidget(
      //       context: context, isError: true, message: error.toString());
      // }
    }

    if (gotCollectionData == false) {
      try {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('patients')
            .doc(auth.currentUser?.uid)
            .get();
        if (documentSnapshot.exists) {
          log("${documentSnapshot.data()}", name: "patient data");

          data = documentSnapshot.data() as Map<String, dynamic>;
        }
        if (data.isNotEmpty) {
          if (context.mounted) {
            gotCollectionData = true;
            appConstants.role = "patient";

            BlocProvider.of<PatientCubit>(context).updatePatientModel(
                singlePatientModel: PatientModel.fromMap(data));
          }
        }
      } catch (error) {
        // if (context.mounted) {
        //   messageWidget(
        //       context: context, isError: true, message: error.toString());
        // }
      }
    }
    if (auth.currentUser != null) {
      ZegoUIKitPrebuiltCallInvitationService().init(
        appID: 4363952,
        appSign:
            "f1e6f0abefbcf0be0a9fa51f909e28c07515c25109378107e9ac46ecba959aaa",
        userID: auth.currentUser!.uid,
        userName: auth.currentUser!.displayName == null
            ? "User"
            : auth.currentUser!.displayName!,
        plugins: [ZegoUIKitSignalingPlugin()],
      );
    }
    if (context.mounted && auth.currentUser != null) {
      BlocProvider.of<UserCubit>(context).updateUserModel(
        email: auth.currentUser!.email.toString(),
        uid: auth.currentUser!.uid.toString(),
        displayName: auth.currentUser!.displayName.toString(),
        photoUrl: auth.currentUser!.photoURL.toString(),
      );
    }
    log("${auth.currentUser?.uid}", name: "user id");
    log("${auth.currentUser?.displayName}", name: "user name");
    if (auth.currentUser?.uid == "SoLtSmVuldhx055d8g0XHqB3Ez23" &&
        context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        CustomPageRoute(child: const AdminLandingScreen()),
        (route) => false, // Close all existing routes
      );
      return;
    } else if (auth.currentUser?.uid != null &&
        gotCollectionData &&
        appConstants.role == "doctor" &&
        doctorProfileStatus != "approved" &&
        context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        CustomPageRoute(child: const ProfileNotApprovedScreen()),
        (route) => false, // Close all existing routes
      );
      return;
    } else if (auth.currentUser?.uid != null &&
        gotCollectionData &&
        (appConstants.role == "doctor" || appConstants.role == "patient")) {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          CustomPageRoute(child: LandingScreen()),
          (route) => false,
        );
      }
      return;
    } else if (auth.currentUser?.uid != null &&
        appConstants.role == "" &&
        gotCollectionData == false &&
        context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        CustomPageRoute(child: RegisterUserRoleScreen()),
        (route) => false, // Close all existing routes
      );
      return;
    } else if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        CustomPageRoute(child: const BoardingScreen()),
        (route) => false, // Close all existing routes
      );
      return;
    }
  }

  TimeOfDay convertTimeStringToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(' ');

    List<String> timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    if (parts[1].toLowerCase() == 'pm' && hour < 12) {
      hour += 12;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  DateTime stringToDateTime({required String dateString}) {
    List<String> dateParts = dateString.split('-');
    DateFormat format = DateFormat("dd-MM-yyyy");
    DateTime dateTime = format.parse(dateString);
    return dateTime;
  }

  Future<void> launchInBrowser(
      {required BuildContext context, required String urlPath}) async {
    try {
      var url = Uri.parse(urlPath);
      if (!await launchUrl(
        url,
        mode: LaunchMode.inAppBrowserView,
      )) {
        throw Exception('Could not launch $url');
      }
    } catch (error) {
      log(error.toString(), name: "error");
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: error.toString());
      }
    }
  }
}
