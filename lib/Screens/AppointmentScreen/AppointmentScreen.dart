import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/Screens/AppointmentScreen/Widgets/AppointmentDetailsDialogWidget.dart';
import 'package:doctor_patient_management_system/cubit/UserCubit/user_cubit.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/AppointmentModel.dart';
import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/CallButtonWidget.dart';
import '../../Widgets/MessageWidget.dart';
import '../../Widgets/RateDoctorDialogWidget.dart';
import '../BookAppointmentScreen/BookAppointmentScreen.dart';
import '../PatientMedicinesScreen/PatientMedicines.dart';
import '../SearchDoctorScreen/SearchDoctorScreen.dart';

class AppointmentScreen extends StatefulWidget {
  AppointmentScreen({super.key, required this.onPressedFunction});

  Function() onPressedFunction;

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int index = 0;
  String doctorId = "";
  String doctorName = "";
  String doctorPhotoUrl = "";

  String current = "Current";

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
            : index == 3
                ? PatientMedicinesScreen(
                    onBackPressed: (ind) {
                      setState(() {
                        index = ind;
                        doctorId = "";
                        doctorName = "";
                        doctorPhotoUrl = "";
                      });
                    },
                  )
                : BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return Container(
                        width: width,
                        height: height,
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (appConstants.role != "patient")
                                Row(
                                  children: [
                                    const Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        await showDialog(
                                            context: context,
                                            builder: (_) => imageDialog(
                                                'My Image',
                                                state.userModel.photoUrl,
                                                context));
                                      },
                                      child: ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(20),
                                          child: Image.network(
                                            state.userModel.photoUrl,
                                            frameBuilder:
                                                (context, child, frame, was) {
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
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child:
                                                            const CircularProgressIndicator(
                                                          color:
                                                              Color(0xff3FA8F9),
                                                        ),
                                                      )));
                                            },
                                            fit: BoxFit.fill,
                                            width: width * 0.75,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (appConstants.role != "patient")
                                Text(
                                  "${FirebaseAuth.instance.currentUser!.displayName}! Welcome to Sehat Sakoon",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          height * appConstants.fontSize20),
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Appointments",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            height * appConstants.fontSize20),
                                  ),
                                  if (appConstants.role == "patient")
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          index = 3;
                                        });
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color:
                                                  Colors.blue.withOpacity(0.2)),
                                          child: Text(
                                            "Medicines",
                                            style: TextStyle(
                                                fontSize: height *
                                                    appConstants.fontSize14,
                                                color: Colors.blue),
                                          )),
                                    ),
                                  // if (appConstants.role == "patient")
                                  //   InkWell(
                                  //     onTap: () {
                                  //       setState(() {
                                  //         index = 1;
                                  //       });
                                  //     },
                                  //     child: Container(
                                  //         padding: const EdgeInsets.all(10),
                                  //         decoration: BoxDecoration(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(8),
                                  //             color: Colors.blue.withOpacity(0.2)),
                                  //         child: const Icon(
                                  //           Icons.add,
                                  //           color: Colors.blue,
                                  //         )),
                                  //   ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        current = "Previous";
                                      });
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: current == "Previous"
                                                ? Colors.blue.withOpacity(0.2)
                                                : Colors.white),
                                        child: Text(
                                          "Previous",
                                          style: TextStyle(
                                              fontSize: height *
                                                  appConstants.fontSize14,
                                              color: Colors.blue),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        current = "Current";
                                      });
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: current == "Current"
                                                ? Colors.blue.withOpacity(0.2)
                                                : Colors.white),
                                        child: Text(
                                          "Current",
                                          style: TextStyle(
                                              fontSize: height *
                                                  appConstants.fontSize14,
                                              color: Colors.blue),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('appointments')
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: CircularProgressIndicator(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          );
                                        }

                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }

                                        List<AppointmentModel> appointments =
                                            [];
                                        if (current == "Current") {
                                          log("message");
                                          appointments =
                                              snapshot.data!.docs.map((doc) {
                                            Map<String, dynamic> data = doc
                                                .data() as Map<String, dynamic>;
                                            return AppointmentModel.fromJson(
                                                data);
                                          }).where((appoint) {
                                            List dates = appoint.appointmentDate
                                                .split("-");
                                            log("${dates[0]}");
                                            return appoint.doctorId ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid &&
                                                DateTime.now().day.toInt() <=
                                                    int.parse(dates[0]) &&
                                                DateTime.now().month.toInt() <=
                                                    int.parse(dates[1]) &&
                                                DateTime.now().year.toInt() <=
                                                    int.parse(dates[2]);
                                          }).toList();
                                        } else {
                                          log("messageeeee");

                                          appointments =
                                              snapshot.data!.docs.map((doc) {
                                            Map<String, dynamic> data = doc
                                                .data() as Map<String, dynamic>;
                                            return AppointmentModel.fromJson(
                                                data);
                                          }).where((appoint) {
                                            List dates = appoint.appointmentDate
                                                .split("-");
                                            log("${dates[0]}");
                                            return appoint.doctorId ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid &&
                                                DateTime.now().day.toInt() >=
                                                    int.parse(dates[0]) &&
                                                DateTime.now().month.toInt() >=
                                                    int.parse(dates[1]) &&
                                                DateTime.now().year.toInt() >=
                                                    int.parse(dates[2]);
                                          }).toList();
                                        }

                                        return SizedBox(
                                          child: ListView.builder(
                                            itemCount: appointments.length,
                                            itemBuilder: (context, index) {
                                              AppointmentModel appointment =
                                                  appointments[index];

                                              TimeOfDay appointedStartTime =
                                                  appConstants.commonServices
                                                      .convertTimeStringToTimeOfDay(
                                                          appointment
                                                              .startTime);
                                              TimeOfDay appointedEndTime =
                                                  appConstants.commonServices
                                                      .convertTimeStringToTimeOfDay(
                                                          appointment.endTime);
                                              DateTime appointmentDate =
                                                  appConstants.commonServices
                                                      .stringToDateTime(
                                                          dateString: appointment
                                                              .appointmentDate);

                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 1,
                                                        blurRadius: 7,
                                                        offset:
                                                            const Offset(0, 3),
                                                      ),
                                                    ]),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                                            .all(
                                                                            20),
                                                                    child:
                                                                        AppointmentDetailsDialogWidget(
                                                                      appointmentModel:
                                                                          appointment,
                                                                    )));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          ClipOval(
                                                            child: SizedBox
                                                                .fromSize(
                                                              size: const Size
                                                                  .fromRadius(
                                                                  25),
                                                              child:
                                                                  Image.network(
                                                                appointment
                                                                    .patientPhotoUrl,
                                                                frameBuilder:
                                                                    (context,
                                                                        child,
                                                                        frame,
                                                                        was) {
                                                                  return child;
                                                                },
                                                                loadingBuilder:
                                                                    (context,
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
                                                                          child: Container(
                                                                            padding:
                                                                                const EdgeInsets.all(20),
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                                                            child:
                                                                                const CircularProgressIndicator(
                                                                              color: Color(0xff3FA8F9),
                                                                            ),
                                                                          )));
                                                                },
                                                                fit:
                                                                    BoxFit.fill,
                                                                width: width *
                                                                    0.75,
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
                                                                appointment
                                                                    .patientName,
                                                                maxLines: 1,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              Text(
                                                                appointment
                                                                    .timeSlot,
                                                                maxLines: 1,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              Text(
                                                                "${appointment.startTime} - ${appointment.endTime}",
                                                                maxLines: 1,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              Text(
                                                                appointment
                                                                    .appointmentDate,
                                                                maxLines: 1,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    if (appointment
                                                                .appointmentType ==
                                                            "Message" &&
                                                        (appointedStartTime
                                                                    .hour >=
                                                                TimeOfDay.now()
                                                                    .hour ||
                                                            appointedStartTime
                                                                    .minute >=
                                                                TimeOfDay.now()
                                                                    .minute) &&
                                                        (appointedEndTime.hour <=
                                                                TimeOfDay.now()
                                                                    .hour ||
                                                            appointedEndTime
                                                                    .minute <=
                                                                TimeOfDay.now()
                                                                    .minute) &&
                                                        (DateTime.now().day ==
                                                                appointmentDate
                                                                    .day &&
                                                            DateTime.now()
                                                                    .month ==
                                                                appointmentDate
                                                                    .month &&
                                                            DateTime.now()
                                                                    .year ==
                                                                appointmentDate
                                                                    .year))
                                                      InkWell(
                                                        onTap: () => widget
                                                            .onPressedFunction(),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .green),
                                                          child: const Icon(
                                                            Icons.message,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    if (appointment
                                                                .appointmentType ==
                                                            "Audio Call" &&
                                                        (appointedStartTime
                                                                    .hour >=
                                                                TimeOfDay.now()
                                                                    .hour ||
                                                            appointedStartTime
                                                                    .minute >=
                                                                TimeOfDay.now()
                                                                    .minute) &&
                                                        (appointedEndTime
                                                                    .hour <=
                                                                TimeOfDay.now()
                                                                    .hour ||
                                                            appointedEndTime
                                                                    .minute <=
                                                                TimeOfDay.now()
                                                                    .minute) &&
                                                        (DateTime.now()
                                                                    .day ==
                                                                appointmentDate
                                                                    .day &&
                                                            DateTime.now()
                                                                    .month ==
                                                                appointmentDate
                                                                    .month &&
                                                            DateTime.now()
                                                                    .year ==
                                                                appointmentDate
                                                                    .year))
                                                      CallButtonWidget(
                                                        isVideoCall: false,
                                                        targetUserId:
                                                            appointment
                                                                .patientId,
                                                        targetUserName:
                                                            appointment
                                                                .patientName,
                                                        targetUserPhotoUrl:
                                                            appointment
                                                                .patientPhotoUrl,
                                                      ),
                                                    if (appointment
                                                                .appointmentType ==
                                                            "Video Call" &&
                                                        (appointedStartTime
                                                                    .hour >=
                                                                TimeOfDay.now()
                                                                    .hour ||
                                                            appointedStartTime
                                                                    .minute >=
                                                                TimeOfDay.now()
                                                                    .minute) &&
                                                        (appointedEndTime
                                                                    .hour <=
                                                                TimeOfDay.now()
                                                                    .hour ||
                                                            appointedEndTime
                                                                    .minute <=
                                                                TimeOfDay.now()
                                                                    .minute) &&
                                                        (DateTime.now()
                                                                    .day ==
                                                                appointmentDate
                                                                    .day &&
                                                            DateTime.now()
                                                                    .month ==
                                                                appointmentDate
                                                                    .month &&
                                                            DateTime.now()
                                                                    .year ==
                                                                appointmentDate
                                                                    .year))
                                                      CallButtonWidget(
                                                        isVideoCall: true,
                                                        targetUserId:
                                                            appointment
                                                                .patientId,
                                                        targetUserName:
                                                            appointment
                                                                .patientName,
                                                        targetUserPhotoUrl:
                                                            appointment
                                                                .patientPhotoUrl,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('appointments')
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: CircularProgressIndicator(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          );
                                        }

                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }
                                        List<AppointmentModel> appointments =
                                            [];
                                        if (current == "Current") {
                                          log("message");
                                          appointments =
                                              snapshot.data!.docs.map((doc) {
                                            Map<String, dynamic> data = doc
                                                .data() as Map<String, dynamic>;
                                            return AppointmentModel.fromJson(
                                                data);
                                          }).where((appoint) {
                                            List dates = appoint.appointmentDate
                                                .split("-");
                                            log("${dates[0]}");
                                            return appoint.patientId ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid &&
                                                DateTime.now().day.toInt() <=
                                                    int.parse(dates[0]) &&
                                                DateTime.now().month.toInt() <=
                                                    int.parse(dates[1]) &&
                                                DateTime.now().year.toInt() <=
                                                    int.parse(dates[2]);
                                          }).toList();
                                        } else {
                                          log("messageeeee");

                                          appointments =
                                              snapshot.data!.docs.map((doc) {
                                            Map<String, dynamic> data = doc
                                                .data() as Map<String, dynamic>;
                                            return AppointmentModel.fromJson(
                                                data);
                                          }).where((appoint) {
                                            List dates = appoint.appointmentDate
                                                .split("-");
                                            log("${dates[0]}");
                                            return appoint.patientId ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid &&
                                                DateTime.now().day.toInt() >=
                                                    int.parse(dates[0]) &&
                                                DateTime.now().month.toInt() >=
                                                    int.parse(dates[1]) &&
                                                DateTime.now().year.toInt() >=
                                                    int.parse(dates[2]);
                                          }).toList();
                                        }

                                        // final documents = snapshot.data!.docs;
                                        return appointments.isEmpty
                                            ? Center(
                                                child: Text(
                                                  "No Appointments",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: height *
                                                          appConstants
                                                              .fontSize18),
                                                ),
                                              )
                                            : SizedBox(
                                                child: ListView.builder(
                                                  itemCount:
                                                      appointments.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    AppointmentModel
                                                        appointment =
                                                        appointments[index];
                                                    TimeOfDay
                                                        appointedStartTime =
                                                        appConstants
                                                            .commonServices
                                                            .convertTimeStringToTimeOfDay(
                                                                appointment
                                                                    .startTime);
                                                    TimeOfDay appointedEndTime =
                                                        appConstants
                                                            .commonServices
                                                            .convertTimeStringToTimeOfDay(
                                                                appointment
                                                                    .endTime);
                                                    DateTime appointmentDate =
                                                        appConstants
                                                            .commonServices
                                                            .stringToDateTime(
                                                                dateString:
                                                                    appointment
                                                                        .appointmentDate);
                                                    // log("$appointedStartTime",
                                                    //     name: "starting date");
                                                    // log("$appointedEndTime",
                                                    //     name: "ending date");
                                                    // log("${appointment.appointmentType}",
                                                    //     name: "appointment type");
                                                    // log("${TimeOfDay.now()}",
                                                    //     name: "now");
                                                    //
                                                    // log("${(appointment.appointmentType == "Message" && (appointedStartTime.hour >= TimeOfDay.now().hour || appointedStartTime.minute >= TimeOfDay.now().minute) && (appointedEndTime.hour <= TimeOfDay.now().hour || appointedEndTime.minute <= TimeOfDay.now().minute) && (DateTime.now().day == appointmentDate.day && DateTime.now().month == appointmentDate.month && DateTime.now().year == appointmentDate.year))}",
                                                    //     name: "condition");
                                                    //
                                                    // log("${(appointment.appointmentType == "Message" && (appointedStartTime.hour >= TimeOfDay.now().hour || appointedStartTime.minute >= TimeOfDay.now().minute) && (appointedEndTime.hour <= TimeOfDay.now().hour || appointedEndTime.minute <= TimeOfDay.now().minute) && (DateTime.now().day == appointmentDate.day && DateTime.now().month == appointmentDate.month && DateTime.now().year == appointmentDate.year))}",
                                                    //     name: "condition 1");

                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 5,
                                                              bottom: 5),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 7,
                                                              offset:
                                                                  const Offset(
                                                                      0, 3),
                                                            ),
                                                          ]),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      Dialog(
                                                                          insetPadding: const EdgeInsets
                                                                              .all(
                                                                              20),
                                                                          child:
                                                                              AppointmentDetailsDialogWidget(
                                                                            appointmentModel:
                                                                                appointment,
                                                                          )));
                                                            },
                                                            child: Row(
                                                              children: [
                                                                ClipOval(
                                                                  child: SizedBox
                                                                      .fromSize(
                                                                    size: const Size
                                                                        .fromRadius(
                                                                        25),
                                                                    child: Image
                                                                        .network(
                                                                      appointment
                                                                          .doctorPhotoUrl,
                                                                      frameBuilder: (context,
                                                                          child,
                                                                          frame,
                                                                          was) {
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
                                                                                child: Container(
                                                                                  padding: const EdgeInsets.all(20),
                                                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                                                                  child: const CircularProgressIndicator(
                                                                                    color: Color(0xff3FA8F9),
                                                                                  ),
                                                                                )));
                                                                      },
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      width: width *
                                                                          0.75,
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
                                                                      appointment
                                                                          .doctorName,
                                                                      maxLines:
                                                                          1,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    Text(
                                                                      appointment
                                                                          .timeSlot,
                                                                      maxLines:
                                                                          1,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                    Text(
                                                                      "${appointment.startTime} - ${appointment.endTime}",
                                                                      maxLines:
                                                                          1,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                    Text(
                                                                      appointment
                                                                          .appointmentDate,
                                                                      maxLines:
                                                                          1,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            20),
                                                                child:
                                                                    ButtonWidget(
                                                                        onPressedFunction:
                                                                            () {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) => Dialog(
                                                                                  insetPadding: const EdgeInsets.all(20),
                                                                                  child: RateDoctorDialogWidget(
                                                                                    doctorId: appointment.doctorId,
                                                                                  )));
                                                                        },
                                                                        buttonText:
                                                                            "Rate",
                                                                        buttonColor:
                                                                            Colors
                                                                                .blue,
                                                                        borderColor:
                                                                            Colors
                                                                                .blue,
                                                                        textColor:
                                                                            Colors
                                                                                .white,
                                                                        buttonWidth:
                                                                            100),
                                                              ),
                                                              if (appointment
                                                                          .appointmentType ==
                                                                      "Message" &&
                                                                  (appointedStartTime
                                                                              .hour >=
                                                                          TimeOfDay.now()
                                                                              .hour ||
                                                                      appointedStartTime
                                                                              .minute >=
                                                                          TimeOfDay.now()
                                                                              .minute) &&
                                                                  (appointedEndTime
                                                                              .hour <=
                                                                          TimeOfDay
                                                                                  .now()
                                                                              .hour ||
                                                                      appointedEndTime
                                                                              .minute <=
                                                                          TimeOfDay
                                                                                  .now()
                                                                              .minute) &&
                                                                  (DateTime.now()
                                                                              .day ==
                                                                          appointmentDate
                                                                              .day &&
                                                                      DateTime.now()
                                                                              .month ==
                                                                          appointmentDate
                                                                              .month &&
                                                                      DateTime.now()
                                                                              .year ==
                                                                          appointmentDate
                                                                              .year))
                                                                InkWell(
                                                                  onTap: () =>
                                                                      widget
                                                                          .onPressedFunction(),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    decoration: const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .green),
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .message,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (appointment
                                                                          .appointmentType ==
                                                                      "Audio Call" &&
                                                                  (appointedStartTime
                                                                              .hour >=
                                                                          TimeOfDay.now()
                                                                              .hour ||
                                                                      appointedStartTime
                                                                              .minute >=
                                                                          TimeOfDay.now()
                                                                              .minute) &&
                                                                  (appointedEndTime
                                                                              .hour <=
                                                                          TimeOfDay
                                                                                  .now()
                                                                              .hour ||
                                                                      appointedEndTime
                                                                              .minute <=
                                                                          TimeOfDay
                                                                                  .now()
                                                                              .minute) &&
                                                                  (DateTime.now()
                                                                              .day ==
                                                                          appointmentDate
                                                                              .day &&
                                                                      DateTime.now()
                                                                              .month ==
                                                                          appointmentDate
                                                                              .month &&
                                                                      DateTime.now()
                                                                              .year ==
                                                                          appointmentDate
                                                                              .year))
                                                                CallButtonWidget(
                                                                  isVideoCall:
                                                                      false,
                                                                  targetUserId:
                                                                      appointment
                                                                          .doctorId,
                                                                  targetUserName:
                                                                      appointment
                                                                          .doctorName,
                                                                  targetUserPhotoUrl:
                                                                      appointment
                                                                          .doctorName,
                                                                ),
                                                              if (appointment
                                                                          .appointmentType ==
                                                                      "Video Call" &&
                                                                  (appointedStartTime
                                                                              .hour >=
                                                                          TimeOfDay.now()
                                                                              .hour ||
                                                                      appointedStartTime
                                                                              .minute >=
                                                                          TimeOfDay.now()
                                                                              .minute) &&
                                                                  (appointedEndTime
                                                                              .hour <=
                                                                          TimeOfDay
                                                                                  .now()
                                                                              .hour ||
                                                                      appointedEndTime
                                                                              .minute <=
                                                                          TimeOfDay
                                                                                  .now()
                                                                              .minute) &&
                                                                  (DateTime.now()
                                                                              .day ==
                                                                          appointmentDate
                                                                              .day &&
                                                                      DateTime.now()
                                                                              .month ==
                                                                          appointmentDate
                                                                              .month &&
                                                                      DateTime.now()
                                                                              .year ==
                                                                          appointmentDate
                                                                              .year))
                                                                CallButtonWidget(
                                                                  isVideoCall:
                                                                      true,
                                                                  targetUserId:
                                                                      appointment
                                                                          .doctorId,
                                                                  targetUserName:
                                                                      appointment
                                                                          .doctorName,
                                                                  targetUserPhotoUrl:
                                                                      appointment
                                                                          .doctorPhotoUrl,
                                                                )
                                                            ],
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
                    },
                  );
  }
}

Widget imageDialog(text, path, context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$text',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close_rounded),
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
        Image.network(
          '$path',
          fit: BoxFit.cover,
        ),
      ],
    ),
  );
}
