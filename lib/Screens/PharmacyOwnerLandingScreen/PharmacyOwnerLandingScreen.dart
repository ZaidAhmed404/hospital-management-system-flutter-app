import 'package:doctor_patient_management_system/Screens/ChatHistoryScreen/ChatHistoryScreen.dart';
import 'package:doctor_patient_management_system/Widgets/MessageWidget.dart';
import 'package:doctor_patient_management_system/cubit/DoctorCubit/doctor_cubit.dart';
import 'package:doctor_patient_management_system/cubit/LoadingCubit/loading_cubit.dart';
import 'package:doctor_patient_management_system/cubit/UserCubit/user_cubit.dart';
import 'package:doctor_patient_management_system/cubit/patient/patient_cubit.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../AppointmentScreen/AppointmentScreen.dart';
import '../CallHistoryScreen/CallHistoryScreen.dart';
import '../PharmacyOwnerMedicineScreen/PharmacyOwnerMedicineScreen.dart';
import '../PharmacyOwnerOrderScreen/PharmacyOwnerOrderScreen.dart';
import '../PharmacyOwnerProfileScreen/PharmacyOwnerProfileScreen.dart';
import '../ProfileScreen/ProfileScreen.dart';

class PharmacyOwnerLandingScreen extends StatefulWidget {
  @override
  _PharmacyOwnerLandingScreenState createState() =>
      _PharmacyOwnerLandingScreenState();
}

class _PharmacyOwnerLandingScreenState
    extends State<PharmacyOwnerLandingScreen> {
  var _currentIndex = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, doctorState) {
            return BlocBuilder<PatientCubit, PatientState>(
              builder: (context, patientState) {
                return LoadingOverlay(
                  isLoading: isLoading,
                  color: Colors.black,
                  opacity: 0.5,
                  progressIndicator: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const CircularProgressIndicator(
                        color: Colors.blue,
                      )),
                  child: SafeArea(
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      body: _currentIndex == 0
                          ? PharmacyOwnerMedicineScreen()
                          : _currentIndex == 1
                              ? const PharmacyOwnerOrderScreen()
                              : _currentIndex == 2
                                  ? const PharmacyOwnerProfileScreen()
                                  : const Text("Others"),
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
                                Icons.medical_information,
                                color: Colors.blue,
                              ),
                            ),
                            title: Text(
                              "Medicines",
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
                                  Icons.paid_outlined,
                                  color: Colors.blue,
                                )),
                            title: Text(
                              "Orders",
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
                      floatingActionButton: FloatingActionButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            dynamic conversationObject = {
                              "appId": "17ff5ef8b9001de0a5e1938354e018c81",
                              "botIds": ["sehat-sakoon-hsv7d"],
                              "conversationAssignee": "sehat-sakoon-hsv7d"
                            };
                            await KommunicateFlutterPlugin.buildConversation(
                                    conversationObject)
                                .then((clientConversationId) {
                              print("Conversation builder success : " +
                                  clientConversationId.toString());
                            }).catchError((error) {
                              print("Conversation builder error : " +
                                  error.toString());
                            });
                          } catch (error) {
                            messageWidget(
                                context: context,
                                isError: true,
                                message: error.toString());
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        backgroundColor: Colors.blue,
                        child: const Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                      ),
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
