import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';

import '../SearchDoctorScreen/SearchDoctorScreen.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return index == 1
        ? SearchDoctorScreen(
            onBackPressed: (ind) {
              setState(() {
                index = ind;
              });
            },
          )
        : Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Appointments",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      if (appConstants.role == "patient")
                        InkWell(
                          onTap: () {
                            setState(() {
                              index = 1;
                            });
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue.withOpacity(0.2)),
                              child: const Icon(
                                Icons.add,
                                color: Colors.blue,
                              )),
                        )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
