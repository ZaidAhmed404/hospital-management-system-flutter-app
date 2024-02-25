import 'package:doctor_patient_management_system/cubit/DoctorCubit/doctor_cubit.dart';
import 'package:doctor_patient_management_system/cubit/UserCubit/user_cubit.dart';
import 'package:doctor_patient_management_system/cubit/patient/patient_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../ProfileScreen/ProfileScreen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, doctorState) {
            return BlocBuilder<PatientCubit, PatientState>(
              builder: (context, patientState) {
                return SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.white.withOpacity(0.98),
                    body: _currentIndex == 3
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
                              Icons.home,
                              color: Colors.blue,
                            ),
                          ),
                          title: const Text(
                            "Home",
                            style: TextStyle(
                              fontSize: 16,
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
                                Icons.favorite_border,
                                color: Colors.blue,
                              )),
                          title: const Text(
                            "Likes",
                            style: TextStyle(
                              fontSize: 16,
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
                                Icons.search,
                                color: Colors.blue,
                              )),
                          title: const Text(
                            "Search",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          selectedColor: Colors.blue,
                        ),
                        SalomonBottomBarItem(
                          icon: Container(
                            padding: const EdgeInsets.all(8),
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
                          title: const Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 16,
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
