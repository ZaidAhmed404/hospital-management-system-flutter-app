import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Models/ChatModel.dart';
import '../../Widgets/TextFieldWidget.dart';
import 'Widgets/ChatWidget.dart';

class ChatScreen extends StatelessWidget {
  Function() onBackPressed;

  String targetId;
  String targetName;
  String targetPhotoUrl;
  bool chatActive;
  String appointmentId;

  ChatScreen(
      {super.key,
      required this.onBackPressed,
      required this.targetId,
      required this.targetPhotoUrl,
      required this.targetName,
      required this.chatActive,
      required this.appointmentId});

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => onBackPressed(),
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue.withOpacity(0.2)),
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.blue,
                    )),
              ),
              const Spacer(),
              Text(
                "Chat",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: height * appConstants.fontSize20),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              stream: appConstants.role == "patient"
                  ? FirebaseFirestore.instance
                      .collection(
                          'chat.$targetId.${FirebaseAuth.instance.currentUser!.uid}.$appointmentId')
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection(
                          'chat.${FirebaseAuth.instance.currentUser!.uid}.$targetId.$appointmentId')
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
                List<ChatModel> chats = snapshot.data!.docs.map((doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  return ChatModel.fromJson(data);
                }).toList();
                chats = chats.reversed.toList();
                log(FirebaseAuth.instance.currentUser!.uid, name: "my user Id");
                return SizedBox(
                  child: ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      return ChatWidget(
                        imageUrl: chats[index].sendBy == "doctor"
                            ? chats[index].doctorPhotoUrl
                            : chats[index].patientPhotoUrl,
                        message: chats[index].message,
                        time: chats[index].time,
                        condition: appConstants.role == chats[index].sendBy,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          if (!chatActive)
            Center(
              child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 5, bottom: 5, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Chat Closed",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: height * appConstants.fontSize14),
                  )),
            ),
          if (chatActive)
            Row(
              children: [
                TextFieldWidget(
                  hintText: "Enter message",
                  text: "",
                  controller: messageController,
                  isPassword: false,
                  isEnabled: true,
                  validationFunction: (value) {
                    return null;
                  },
                  textInputType: TextInputType.text,
                  textFieldWidth: width * 0.8,
                  haveText: false,
                  onValueChange: (value) {},
                  maxLines: 1,
                  borderCircular: 50,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    appConstants.chatServices.sendMessage(
                        patientId: appConstants.role == "doctor"
                            ? FirebaseAuth.instance.currentUser!.uid
                            : targetId,
                        patientName: appConstants.role == "doctor"
                            ? FirebaseAuth.instance.currentUser!.displayName!
                            : targetName,
                        patientPhotoUrl: appConstants.role == "doctor"
                            ? FirebaseAuth.instance.currentUser!.photoURL!
                            : targetPhotoUrl,
                        doctorName: appConstants.role == "patient"
                            ? FirebaseAuth.instance.currentUser!.displayName!
                            : targetName,
                        doctorPhotoUrl: appConstants.role == "patient"
                            ? FirebaseAuth.instance.currentUser!.photoURL!
                            : targetPhotoUrl,
                        doctorId: appConstants.role == "patient"
                            ? FirebaseAuth.instance.currentUser!.uid
                            : targetId,
                        message: messageController.text,
                        appointmentId: appointmentId,
                        context: context);
                    messageController.text = "";
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: height * appConstants.fontSize15,
                    ),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
