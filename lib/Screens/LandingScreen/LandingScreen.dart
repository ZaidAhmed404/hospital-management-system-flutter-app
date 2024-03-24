import 'package:doctor_patient_management_system/Screens/ChatHistoryScreen/ChatHistoryScreen.dart';
import 'package:doctor_patient_management_system/cubit/DoctorCubit/doctor_cubit.dart';
import 'package:doctor_patient_management_system/cubit/UserCubit/user_cubit.dart';
import 'package:doctor_patient_management_system/cubit/patient/patient_cubit.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../AppointmentScreen/AppointmentScreen.dart';
import '../CallHistoryScreen/CallHistoryScreen.dart';
import '../ProfileScreen/ProfileScreen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, doctorState) {
            return BlocBuilder<PatientCubit, PatientState>(
              builder: (context, patientState) {
                return SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    body: _currentIndex == 0
                        ? const AppointmentScreen()
                        : _currentIndex == 1
                            ? const ChatHistoryScreen()
                            : _currentIndex == 2
                                ? const CallHistoryScreen()
                                : _currentIndex == 3
                                    ? ProfileScreen(
                                        patientModel: patientState.patientModel,
                                        userModel: userState.userModel,
                                        doctorModel: doctorState.doctorModel,
                                      )
                                    : const Center(child: Text("Other")),
                    bottomNavigationBar: SalomonBottomBar(
                      currentIndex: _currentIndex,
                      onTap: (i) => setState(() => _currentIndex = i),
                      items: [
                        SalomonBottomBarItem(
                          icon: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: _currentIndex == 0
                                    ? null
                                    : Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Icon(
                              Icons.call_to_action,
                              color: Colors.blue,
                            ),
                          ),
                          title: Text(
                            "Appointments",
                            style: TextStyle(
                              fontSize: height * appConstants.fontSize14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          selectedColor: Colors.blue,
                        ),
                        SalomonBottomBarItem(
                          icon: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: _currentIndex == 1
                                      ? null
                                      : Colors.blue.withOpacity(0.2)),
                              child: const Icon(
                                Icons.chat,
                                color: Colors.blue,
                              )),
                          title: Text(
                            "Chat",
                            style: TextStyle(
                              fontSize: height * appConstants.fontSize14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          selectedColor: Colors.blue,
                        ),
                        SalomonBottomBarItem(
                          icon: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: _currentIndex == 2
                                      ? null
                                      : Colors.blue.withOpacity(0.2)),
                              child: const Icon(
                                Icons.call,
                                color: Colors.blue,
                              )),
                          title: Text(
                            "Calls",
                            style: TextStyle(
                              fontSize: height * appConstants.fontSize14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          selectedColor: Colors.blue,
                        ),
                        SalomonBottomBarItem(
                          icon: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: _currentIndex == 3
                                    ? null
                                    : Colors.blue.withOpacity(0.2)),
                            child: const Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                          ),
                          title: Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: height * appConstants.fontSize14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          selectedColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
