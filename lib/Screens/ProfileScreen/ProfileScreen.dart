import 'dart:developer';
import 'dart:io';

import 'package:doctor_patient_management_system/Models/PatientModel.dart';
import 'package:doctor_patient_management_system/Route/CustomPageRoute.dart';
import 'package:doctor_patient_management_system/Screens/FAQScreen/FAQScreen.dart';
import 'package:doctor_patient_management_system/Screens/PrivacyPolicyScreen/PrivacyPolicyScreen.dart';
import 'package:doctor_patient_management_system/Screens/TermsAndConditionsScreen/TermsAndConditionsScreen.dart';
import 'package:doctor_patient_management_system/cubit/LoadingCubit/loading_cubit.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Models/UserModel.dart';
import '../../../Widgets/IconTextTileWidget.dart';
import '../../Models/DoctorModel.dart';
import '../EditProfileScreen/EditProfileScreen.dart';
import '../SignInScreen/SignInScreen.dart';

class ProfileScreen extends StatefulWidget {
  PatientModel? patientModel;
  UserModel userModel;
  DoctorModel? doctorModel;

  ProfileScreen(
      {super.key,
      required this.patientModel,
      required this.userModel,
      required this.doctorModel});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

const List<String> genders = <String>['Male', "Female", "Others"];

String gender = genders.first;

class _ProfileScreenState extends State<ProfileScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return index == 1
        ? EditProfileScreen(
            userModel: widget.userModel,
            patientModel: widget.patientModel,
            doctorModel: widget.doctorModel,
            backPressedFunction: (int ind) {
              setState(() {
                index = ind;
              });
            },
          )
        : index == 2
            ? TermsAndConditionsScreen(backPressedFunction: (int ind) {
                setState(() {
                  index = ind;
                });
              })
            : index == 3
                ? PrivacyPolicyScreen(backPressedFunction: (int ind) {
                    setState(() {
                      index = ind;
                    });
                  })
                : index == 4
                    ? FAQScreen(backPressedFunction: (int ind) {
                        setState(() {
                          index = ind;
                        });
                      })
                    : BlocBuilder<LoadingCubit, LoadingState>(
                        builder: (context, state) {
                          return LoadingOverlay(
                            isLoading: state.loading,
                            color: Colors.black,
                            opacity: 0.5,
                            progressIndicator: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const CircularProgressIndicator()),
                            child: Container(
                              width: width,
                              height: height,
                              padding: const EdgeInsets.all(20),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          "Profile",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                        const Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  index = 1;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              )),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: ClipOval(
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(48),
                                              child: Image.network(
                                                widget.userModel.photoUrl,
                                                frameBuilder: (context, child,
                                                    frame, was) {
                                                  return child;
                                                },
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                      child: SizedBox(
                                                          width: 70,
                                                          height: 70,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child:
                                                                const CircularProgressIndicator(
                                                              color: Color(
                                                                  0xff3FA8F9),
                                                            ),
                                                          )));
                                                },
                                                fit: BoxFit.fill,
                                                width: width * 0.75,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${FirebaseAuth.instance.currentUser?.displayName}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              "${FirebaseAuth.instance.currentUser?.email}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    IconTextTileWidget(
                                      onPressedFunction: () {
                                        setState(() {
                                          index = 2;
                                        });
                                      },
                                      text: "Terms and Conditions",
                                      firstIcon: Icons.question_answer,
                                      secondIcon: Icons.arrow_forward_ios_sharp,
                                      iconBackgroundColor:
                                          Colors.blue.withOpacity(0.2),
                                      iconColor: Colors.blue,
                                      haveSecondIcon: true,
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    IconTextTileWidget(
                                      onPressedFunction: () {
                                        setState(() {
                                          index = 3;
                                        });
                                      },
                                      text: "Privacy Policy",
                                      firstIcon: Icons.question_answer,
                                      secondIcon: Icons.arrow_forward_ios_sharp,
                                      iconBackgroundColor:
                                          Colors.blue.withOpacity(0.2),
                                      iconColor: Colors.blue,
                                      haveSecondIcon: true,
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    IconTextTileWidget(
                                      onPressedFunction: () {
                                        setState(() {
                                          index = 4;
                                        });
                                      },
                                      text: "FAQ",
                                      firstIcon: Icons.question_answer,
                                      secondIcon: Icons.arrow_forward_ios_sharp,
                                      iconBackgroundColor:
                                          Colors.blue.withOpacity(0.2),
                                      iconColor: Colors.blue,
                                      haveSecondIcon: true,
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    // IconTextTileWidget(
                                    //   onPressedFunction: () {},
                                    //   text: "Help",
                                    //   firstIcon: Icons.help,
                                    //   secondIcon: Icons.arrow_forward_ios_sharp,
                                    //   iconBackgroundColor: Colors.blue.withOpacity(0.2),
                                    //   iconColor: Colors.blue,
                                    //   haveSecondIcon: true,
                                    // ),
                                    // Divider(
                                    //   color: Colors.black.withOpacity(0.1),
                                    // ),
                                    IconTextTileWidget(
                                      onPressedFunction: () {
                                        Share.share(appConstants.shareMessage);
                                      },
                                      text: "Invite Friends",
                                      firstIcon: Icons.person_add_alt_rounded,
                                      secondIcon: Icons.arrow_forward_ios_sharp,
                                      iconBackgroundColor:
                                          Colors.blue.withOpacity(0.2),
                                      iconColor: Colors.blue,
                                      haveSecondIcon: true,
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    IconTextTileWidget(
                                      onPressedFunction: () {
                                        FirebaseAuth.instance.signOut();
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          CustomPageRoute(
                                              child: SignInScreen()),
                                          (route) => false,
                                        );
                                      },
                                      text: "Logout",
                                      haveSecondIcon: false,
                                      firstIcon: Icons.logout,
                                      secondIcon: Icons.arrow_forward_ios_sharp,
                                      iconBackgroundColor:
                                          Colors.red.withOpacity(0.2),
                                      iconColor: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
  }
}
