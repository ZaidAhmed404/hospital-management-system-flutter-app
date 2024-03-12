import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/DoctorModel.dart';
import '../Models/PatientModel.dart';
import '../Route/CustomPageRoute.dart';
import '../Screens/AdminLandingScreen/AdminLandingScreen.dart';
import '../Screens/BoardingScreen/BoardingScreen.dart';
import '../Screens/LandingScreen/LandingScreen.dart';
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

    bool isLoading = false;
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(FirebaseAuth.instance.currentUser?.uid)
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
            .doc(FirebaseAuth.instance.currentUser?.uid)
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
    if (context.mounted && FirebaseAuth.instance.currentUser != null) {
      BlocProvider.of<UserCubit>(context).updateUserModel(
        email: FirebaseAuth.instance.currentUser!.email.toString(),
        uid: FirebaseAuth.instance.currentUser!.uid.toString(),
        displayName: FirebaseAuth.instance.currentUser!.displayName.toString(),
        photoUrl: FirebaseAuth.instance.currentUser!.photoURL.toString(),
      );
    }

    if (auth.currentUser?.uid == "SoLtSmVuldhx055d8g0XHqB3Ez23") {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          CustomPageRoute(child: const AdminLandingScreen()),
          (route) => false, // Close all existing routes
        );
      }
    } else if (gotCollectionData &&
        (appConstants.role == "doctor" || appConstants.role == "patient") &&
        isLoading == false) {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          CustomPageRoute(child: LandingScreen()),
          (route) => false, // Close all existing routes
        );
      }
    } else if (appConstants.role == "" &&
        isLoading == false &&
        gotCollectionData == true) {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          CustomPageRoute(child: RegisterUserRoleScreen()),
          (route) => false, // Close all existing routes
        );
      }
    } else {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          CustomPageRoute(child: const BoardingScreen()),
          (route) => false, // Close all existing routes
        );
      }
    }
  }
}
