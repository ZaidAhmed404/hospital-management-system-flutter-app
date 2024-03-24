import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Models/CallLogModel.dart';

class CallHistoryScreen extends StatelessWidget {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Call History",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: height * appConstants.fontSize20),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.75,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('callLogs').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
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
                  return Text('Error: ${snapshot.error}');
                }
                List<CallLogModel> callLogs = snapshot.data!.docs
                    .map((doc) {
                      Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      return CallLogModel.fromJson(data);
                    })
                    .where((appoint) => (appoint.callerId ==
                            FirebaseAuth.instance.currentUser!.uid ||
                        appoint.targetUserId ==
                            FirebaseAuth.instance.currentUser!.uid))
                    .toList();
                return SizedBox(
                  child: ListView.builder(
                    itemCount: callLogs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(20),
                                  child: Image.network(
                                    callLogs[index].callerId ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? callLogs[index].targetUserPhotoUrl
                                        : callLogs[index].callerPhotoUrl,
                                    frameBuilder: (context, child, frame, was) {
                                      return child;
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                          child: SizedBox(
                                              width: 70,
                                              height: 70,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child:
                                                    const CircularProgressIndicator(
                                                  color: Color(0xff3FA8F9),
                                                ),
                                              )));
                                    },
                                    fit: BoxFit.fill,
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    callLogs[index].callerId ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? callLogs[index].targetUserName
                                        : callLogs[index].callerName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            height * appConstants.fontSize15),
                                  ),
                                  Text(
                                    callLogs[index].time,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            height * appConstants.fontSize15),
                                  ),
                                  Text(
                                    callLogs[index].date,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            height * appConstants.fontSize15),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                                child: Icon(
                                  callLogs[index].callerId ==
                                          FirebaseAuth.instance.currentUser!.uid
                                      ? Icons.call_made
                                      : Icons.call_received,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            color: Colors.grey,
                          )
                        ],
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
