import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/Screens/AppointmentScreen/Widgets/AppointmentDetailsDialogWidget.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';

import '../../Models/AppointmentModel.dart';
import '../../Widgets/CallButtonWidget.dart';
import '../../Widgets/MessageWidget.dart';
import '../BookAppointmentScreen/BookAppointmentScreen.dart';
import '../SearchDoctorScreen/SearchDoctorScreen.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int index = 0;
  String doctorId = "";
  String doctorName = "";
  String doctorPhotoUrl = "";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return index == 1
        ? SearchDoctorScreen(
            onBackPressed: (ind) {
              setState(() {
                index = ind;
                doctorId = "";

                doctorName = "";
                doctorPhotoUrl = "";
              });
            },
            onBookPressed: (ind, id, name, photoUrl) {
              setState(() {
                index = ind;
                doctorId = id;

                doctorName = name;
                doctorPhotoUrl = photoUrl;
              });
            },
          )
        : index == 2
            ? BookAppointmentScreen(
                onBackPressed: (ind) {
                  setState(() {
                    index = ind;
                    doctorId = "";
                    doctorName = "";
                    doctorPhotoUrl = "";
                  });
                },
                doctorId: doctorId,
                doctorName: doctorName,
                doctorPhotoUrl: doctorPhotoUrl,
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
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (appConstants.role == "doctor")
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('appointments')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    child: const CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                List<AppointmentModel> appointments =
                                    snapshot.data!.docs.map((doc) {
                                  Map<String, dynamic> data =
                                      doc.data() as Map<String, dynamic>;
                                  return AppointmentModel.fromJson(data);
                                }).toList();

                                // final documents = snapshot.data!.docs;
                                return SizedBox(
                                  child: ListView.builder(
                                    itemCount: appointments.length,
                                    itemBuilder: (context, index) {
                                      AppointmentModel appointment =
                                          appointments[index];

                                      TimeOfDay appointedStartTime =
                                          appConstants.commonServices
                                              .convertTimeStringToTimeOfDay(
                                                  appointment.startTime);
                                      TimeOfDay appointedEndTime = appConstants
                                          .commonServices
                                          .convertTimeStringToTimeOfDay(
                                              appointment.endTime);
                                      return Container(
                                        margin: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3),
                                              ),
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        Dialog(
                                                            insetPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child:
                                                                AppointmentDetailsDialogWidget(
                                                              appointmentModel:
                                                                  appointment,
                                                            )));
                                              },
                                              child: Row(
                                                children: [
                                                  ClipOval(
                                                    child: SizedBox.fromSize(
                                                      size:
                                                          const Size.fromRadius(
                                                              25),
                                                      child: Image.network(
                                                        appointment
                                                            .patientPhotoUrl,
                                                        frameBuilder: (context,
                                                            child, frame, was) {
                                                          return child;
                                                        },
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return Center(
                                                              child: SizedBox(
                                                                  width: 70,
                                                                  height: 70,
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            20),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
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
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        appointment.patientName,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        appointment.timeSlot,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Text(
                                                        "${appointment.startTime} - ${appointment.endTime}",
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Text(
                                                        appointment
                                                            .appointmentDate,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (appointment.appointmentType ==
                                                    "Message" &&
                                                (appointedStartTime.hour >=
                                                        TimeOfDay.now().hour &&
                                                    appointedStartTime.minute >=
                                                        TimeOfDay.now()
                                                            .minute) &&
                                                (appointedEndTime.hour <=
                                                        TimeOfDay.now().hour &&
                                                    appointedEndTime.minute <=
                                                        TimeOfDay.now().minute))
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.green),
                                                child: const Icon(
                                                  Icons.message,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            if (appointment.appointmentType ==
                                                    "Audio Call" &&
                                                (appointedStartTime.hour >=
                                                        TimeOfDay.now().hour &&
                                                    appointedStartTime.minute >=
                                                        TimeOfDay.now()
                                                            .minute) &&
                                                (appointedEndTime.hour <=
                                                        TimeOfDay.now().hour &&
                                                    appointedEndTime.minute <=
                                                        TimeOfDay.now().minute))
                                              CallButtonWidget(
                                                isVideoCall: false,
                                                targetUserId:
                                                    appointment.patientId,
                                                targetUserName:
                                                    appointment.patientName,
                                              ),
                                            if (appointment.appointmentType ==
                                                    "Video Call" &&
                                                (appointedStartTime.hour >=
                                                        TimeOfDay.now().hour &&
                                                    appointedStartTime.minute >=
                                                        TimeOfDay.now()
                                                            .minute) &&
                                                (appointedEndTime.hour <=
                                                        TimeOfDay.now().hour &&
                                                    appointedEndTime.minute <=
                                                        TimeOfDay.now().minute))
                                              CallButtonWidget(
                                                isVideoCall: true,
                                                targetUserId:
                                                    appointment.patientId,
                                                targetUserName:
                                                    appointment.patientName,
                                              )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            )),
                      if (appConstants.role == "patient")
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('appointments')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    child: const CircularProgressIndicator(
                                      color: Colors.blue,
                                    ),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                List<AppointmentModel> appointments =
                                    snapshot.data!.docs.map((doc) {
                                  Map<String, dynamic> data =
                                      doc.data() as Map<String, dynamic>;
                                  return AppointmentModel.fromJson(data);
                                }).toList();

                                // final documents = snapshot.data!.docs;
                                return SizedBox(
                                  child: ListView.builder(
                                    itemCount: appointments.length,
                                    itemBuilder: (context, index) {
                                      AppointmentModel appointment =
                                          appointments[index];
                                      TimeOfDay appointedStartTime =
                                          appConstants.commonServices
                                              .convertTimeStringToTimeOfDay(
                                                  appointment.startTime);
                                      TimeOfDay appointedEndTime = appConstants
                                          .commonServices
                                          .convertTimeStringToTimeOfDay(
                                              appointment.endTime);
                                      return Container(
                                        margin: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3),
                                              ),
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        Dialog(
                                                            insetPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child:
                                                                AppointmentDetailsDialogWidget(
                                                              appointmentModel:
                                                                  appointment,
                                                            )));
                                              },
                                              child: Row(
                                                children: [
                                                  ClipOval(
                                                    child: SizedBox.fromSize(
                                                      size:
                                                          const Size.fromRadius(
                                                              25),
                                                      child: Image.network(
                                                        appointment
                                                            .doctorPhotoUrl,
                                                        frameBuilder: (context,
                                                            child, frame, was) {
                                                          return child;
                                                        },
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return Center(
                                                              child: SizedBox(
                                                                  width: 70,
                                                                  height: 70,
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            20),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
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
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        appointment.doctorName,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        appointment.timeSlot,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Text(
                                                        "${appointment.startTime} - ${appointment.endTime}",
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      Text(
                                                        appointment
                                                            .appointmentDate,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (appointment.appointmentType ==
                                                    "Message" &&
                                                (appointedStartTime.hour >=
                                                        TimeOfDay.now().hour &&
                                                    appointedStartTime.minute >=
                                                        TimeOfDay.now()
                                                            .minute) &&
                                                (appointedEndTime.hour <=
                                                        TimeOfDay.now().hour &&
                                                    appointedEndTime.minute <=
                                                        TimeOfDay.now().minute))
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.green),
                                                child: const Icon(
                                                  Icons.message,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            if (appointment.appointmentType ==
                                                    "Audio Call" &&
                                                (appointedStartTime.hour >=
                                                        TimeOfDay.now().hour &&
                                                    appointedStartTime.minute >=
                                                        TimeOfDay.now()
                                                            .minute) &&
                                                (appointedEndTime.hour <=
                                                        TimeOfDay.now().hour &&
                                                    appointedEndTime.minute <=
                                                        TimeOfDay.now().minute))
                                              CallButtonWidget(
                                                isVideoCall: false,
                                                targetUserId:
                                                    appointment.patientId,
                                                targetUserName:
                                                    appointment.patientName,
                                              ),
                                            if (appointment.appointmentType ==
                                                    "Video Call" &&
                                                (appointedStartTime.hour >=
                                                        TimeOfDay.now().hour &&
                                                    appointedStartTime.minute >=
                                                        TimeOfDay.now()
                                                            .minute) &&
                                                (appointedEndTime.hour <=
                                                        TimeOfDay.now().hour &&
                                                    appointedEndTime.minute <=
                                                        TimeOfDay.now().minute))
                                              CallButtonWidget(
                                                isVideoCall: true,
                                                targetUserId:
                                                    appointment.patientId,
                                                targetUserName:
                                                    appointment.patientName,
                                              )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            )),
                    ],
                  ),
                ),
              );
  }
}
