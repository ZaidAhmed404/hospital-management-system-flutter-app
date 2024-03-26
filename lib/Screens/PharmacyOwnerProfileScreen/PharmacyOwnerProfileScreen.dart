import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Route/CustomPageRoute.dart';
import '../../Widgets/ButtonWidget.dart';
import '../SignInScreen/SignInScreen.dart';

class PharmacyOwnerProfileScreen extends StatelessWidget {
  const PharmacyOwnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(48),
                    child: Image.asset("assets/images/admin.png"),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pharmacy Owner",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: height * appConstants.fontSize18),
                  ),
                  Text(
                    "${FirebaseAuth.instance.currentUser!.email}",
                    style: TextStyle(
                        fontSize: height * appConstants.fontSize14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          ButtonWidget(
              buttonText: "Logout",
              buttonWidth: MediaQuery.of(context).size.width,
              buttonColor: Colors.blueAccent,
              borderColor: Colors.blueAccent,
              textColor: Colors.white,
              onPressedFunction: () =>
                  appConstants.firebaseAuthServices.logout(context: context)),
        ],
      ),
    );
  }
}
