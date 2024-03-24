import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/Screens/ChatScreen/ChatScreen.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Models/CallLogModel.dart';
import '../../Models/ChatHistoryModel.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  int pageIndex = 0;
  String targetId = "";
  String targetName = "";
  String targetPhotoUrl = "";
  bool chatActive = false;
  String appointmentId = "";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return pageIndex == 1
        ? ChatScreen(
            onBackPressed: () {
              FocusScope.of(context).unfocus();
              setState(() {
                pageIndex = 0;
                targetId = "";
                targetName = "";
                targetPhotoUrl = "";
                chatActive = false;
                appointmentId = "";
              });
            },
            targetId: targetId,
            targetName: targetName,
            targetPhotoUrl: targetPhotoUrl,
            chatActive: chatActive,
            appointmentId: appointmentId,
          )
        : Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chats History",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: height * appConstants.fontSize20),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chatLogs')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      List<ChatHistoryModel> chatHistoryLogs = snapshot
                          .data!.docs
                          .map((doc) {
                            Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            return ChatHistoryModel.fromJson(data);
                          })
                          .where((appoint) => (appoint.patientId ==
                                  FirebaseAuth.instance.currentUser!.uid ||
                              appoint.doctorId ==
                                  FirebaseAuth.instance.currentUser!.uid))
                          .toList();
                      final documents = snapshot.data!.docs;
                      return SizedBox(
                        child: ListView.builder(
                          itemCount: chatHistoryLogs.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                TimeOfDay appointedEndTime = appConstants
                                    .commonServices
                                    .convertTimeStringToTimeOfDay(
                                        chatHistoryLogs[index].endTime);
                                DateTime appointmentDate = appConstants
                                    .commonServices
                                    .stringToDateTime(
                                        dateString: chatHistoryLogs[index]
                                            .appointmentDate);

                                chatActive = (appointedEndTime.hour <=
                                            TimeOfDay.now().hour ||
                                        appointedEndTime.minute <=
                                            TimeOfDay.now().minute) &&
                                    (DateTime.now().day ==
                                            appointmentDate.day &&
                                        DateTime.now().month ==
                                            appointmentDate.month &&
                                        DateTime.now().year ==
                                            appointmentDate.year);

                                if (chatHistoryLogs[index].doctorId ==
                                    FirebaseAuth.instance.currentUser!.uid) {
                                  setState(() {
                                    targetId = chatHistoryLogs[index].patientId;
                                    targetName =
                                        chatHistoryLogs[index].patientName;
                                    targetPhotoUrl =
                                        chatHistoryLogs[index].patientPhotoUrl;
                                    appointmentId = documents[index].id;
                                  });
                                } else {
                                  setState(() {
                                    targetId = chatHistoryLogs[index].doctorId;
                                    targetName =
                                        chatHistoryLogs[index].doctorName;
                                    targetPhotoUrl =
                                        chatHistoryLogs[index].doctorPhotoUrl;
                                    appointmentId = documents[index].id;
                                  });
                                }
                                setState(() {
                                  pageIndex = 1;
                                });
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(20),
                                          child: Image.network(
                                            chatHistoryLogs[index].patientId ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid
                                                ? chatHistoryLogs[index]
                                                    .doctorPhotoUrl
                                                : chatHistoryLogs[index]
                                                    .patientPhotoUrl,
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.75,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            chatHistoryLogs[index].doctorId ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid
                                                ? chatHistoryLogs[index]
                                                    .patientName
                                                : chatHistoryLogs[index]
                                                    .doctorName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: height *
                                                    appConstants.fontSize15),
                                          ),
                                          Text(
                                            chatHistoryLogs[index].date,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: height *
                                                    appConstants.fontSize15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
