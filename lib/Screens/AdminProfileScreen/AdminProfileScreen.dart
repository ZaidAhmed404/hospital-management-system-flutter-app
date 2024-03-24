import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Route/CustomPageRoute.dart';
import '../../Widgets/ButtonWidget.dart';
import '../SignInScreen/SignInScreen.dart';
import 'Widgets/AnalyticsWidget.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  int doctorsCount = 0;
  int patientCount = 0;
  int pharmacyCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAnalytics();
  }

  bool isLoading = false;

  getAnalytics() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection("doctors").count().get().then(
          (res) => doctorsCount = res.count != null ? res.count! : 0,
        );
    log("$doctorsCount");
    await FirebaseFirestore.instance.collection("patients").count().get().then(
          (res) => patientCount = res.count != null ? res.count! : 0,
        );
    log("$patientCount");
    await FirebaseFirestore.instance
        .collection("pharmacies")
        .count()
        .get()
        .then(
          (res) => pharmacyCount = res.count != null ? res.count! : 0,
        );
    setState(() {
      isLoading = false;
    });
  }

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
                    "Admin",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: height * appConstants.fontSize18),
                  ),
                  Text(
                    "Admin@gmail.com",
                    style: TextStyle(
                        fontSize: height * appConstants.fontSize14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
          Text(
            "Analytics",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: height * appConstants.fontSize20),
          ),
          if (isLoading)
            const Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            )),
          if (isLoading == false)
            AnalyticsWidget(
                height: height,
                firstText: "Doctors",
                secondText: doctorsCount.toString()),
          if (isLoading == false)
            AnalyticsWidget(
                height: height,
                firstText: "Patients",
                secondText: patientCount.toString()),
          if (isLoading == false)
            AnalyticsWidget(
                height: height,
                firstText: "Pharmacies",
                secondText: pharmacyCount.toString()),
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
