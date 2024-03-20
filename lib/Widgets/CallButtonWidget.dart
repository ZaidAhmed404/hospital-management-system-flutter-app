import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallButtonWidget extends StatelessWidget {
  CallButtonWidget(
      {super.key,
      required this.isVideoCall,
      required this.targetUserId,
      required this.targetUserName,
      required this.targetUserPhotoUrl});

  bool isVideoCall;
  String targetUserId;
  String targetUserName;

  String targetUserPhotoUrl;

  @override
  Widget build(BuildContext context) {
    return ZegoSendCallInvitationButton(
      padding: EdgeInsets.zero,
      iconSize: const Size(35, 35),
      margin: EdgeInsets.zero,
      buttonSize: const Size(35, 35),
      isVideoCall: isVideoCall,
      resourceID: "zego_call",
      onPressed: (_, __, ___) {
        appConstants.callServices.addCallRecord(
            callerId: FirebaseAuth.instance.currentUser!.uid,
            callerName: FirebaseAuth.instance.currentUser!.displayName!,
            callerPhotoUrl: FirebaseAuth.instance.currentUser!.photoURL!,
            targetUserId: targetUserId,
            targetUserName: targetUserName,
            targetUserPhotoUrl: targetUserPhotoUrl,
            callType: isVideoCall ? "video" : "audio");
      },
      invitees: [
        ZegoUIKitUser(
          id: targetUserId,
          name: targetUserName,
        ),
      ],
    );
  }
}
