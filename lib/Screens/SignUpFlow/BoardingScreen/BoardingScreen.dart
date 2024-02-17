import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/Models/DoctorModel.dart';
import 'package:doctor_patient_management_system/cubit/DoctorCubit/doctor_cubit.dart';
import 'package:doctor_patient_management_system/cubit/UserCubit/user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Widgets/ButtonWidget.dart';
import '../../Doctor/LandingScreen/LandingScreen.dart';
import '../RegisterUserRoleScreen/RegisterUserRolesScreen.dart';
import '../WelcomeScreen/WelcomeScreen.dart';

class BoardingScreen extends StatefulWidget {
  BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  List<Map> boarding = [
    {
      "image": "assets/images/boarding 1.jpg",
      "heading": "Thousands of doctors",
      "description":
          "You can easily contact with a thousands of Doctors and contact for you need"
    },
    {
      "image": "assets/images/boarding 2.jpg",
      "heading": "Chat With doctors",
      "description":
          "Book an appointment with doctor. Chat with doctor via appointment letter and get consultation"
    },
    {
      "image": "assets/images/boarding 3.jpg",
      "heading": "Live talk with doctor",
      "description":
          "Easily Contact with Doctor, start voice and video call for your better treatment and prescription"
    },
  ];

  final PageController _pageController = PageController(initialPage: 0);
  bool isLoading = false;
  bool gotCollectionData = false;
  String role = "";
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.98),
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, snapshot) {
              User? user = snapshot.data;

              if (snapshot.connectionState == ConnectionState.waiting &&
                  !snapshot.hasData &&
                  gotCollectionData == false &&
                  isLoading == true) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasData &&
                  gotCollectionData &&
                  role == "doctor") {
                return DoctorLandingScreen(
                  user: user,
                );
              } else if (snapshot.hasData &&
                  gotCollectionData &&
                  role == "patient") {
                return const Center(
                  child: Text("Patient"),
                );
              } else if (snapshot.hasData && gotCollectionData == false) {
                FirebaseFirestore.instance
                    .collection('doctors')
                    .doc(user?.uid)
                    .get()
                    .then((DocumentSnapshot documentSnapshot) {
                  if (documentSnapshot.exists) {
                    log("${documentSnapshot.data()}", name: "collection data");
                    if (documentSnapshot.exists) {
                      data = documentSnapshot.data() as Map<String, dynamic>;
                    }
                  }
                }).whenComplete(() {
                  if (data.isNotEmpty) {
                    if (context.mounted) {
                      setState(() {
                        gotCollectionData = true;
                        role = "doctor";
                      });
                    }
                    BlocProvider.of<DoctorCubit>(context).updateDoctorModel(
                        singleDoctorModel: DoctorModel.fromMap(data));
                  }
                });
                if (gotCollectionData == false) {
                  FirebaseFirestore.instance
                      .collection('patients')
                      .doc(user?.uid)
                      .get()
                      .then((DocumentSnapshot documentSnapshot) {
                    if (documentSnapshot.exists) {
                      data = documentSnapshot.data() as Map<String, dynamic>;
                    }
                  }).whenComplete(() {
                    if (context.mounted) {
                      if (data.isNotEmpty) {
                        setState(() {
                          gotCollectionData = true;
                          role = "patient";
                        });
                      }
                    }
                  });
                }

                BlocProvider.of<UserCubit>(context).updateUserModel(
                  email: user!.email.toString(),
                  uid: user.uid.toString(),
                  displayName: user.displayName.toString(),
                  photoUrl: user.photoURL.toString(),
                );
                return RegisterUserRoleScreen(
                  user: user,
                );
              } else {
                return PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {},
                    itemCount: boarding.length + 1,
                    itemBuilder: (_, index) {
                      return index == boarding.length
                          ? const WelcomeScreen()
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          boarding[index]['image']))),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40))),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        boarding[index]['heading'],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.blue),
                                      ),
                                      Text(
                                        boarding[index]['description'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          for (int i = 0;
                                              i < boarding.length;
                                              i++)
                                            Container(
                                              width: 5,
                                              height: 5,
                                              margin: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: (i == index)
                                                      ? Colors.black
                                                      : Colors.black12,
                                                  shape: BoxShape.circle),
                                            )
                                        ],
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            _pageController
                                                .jumpToPage(boarding.length);
                                          },
                                          child: const Text(
                                            "Skip",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      ButtonWidget(
                                          buttonText: "Next",
                                          buttonColor: Colors.blueAccent,
                                          borderColor: Colors.blueAccent,
                                          textColor: Colors.white,
                                          onPressedFunction: () {
                                            _pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.ease,
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    });
              }
            }));
  }
}
