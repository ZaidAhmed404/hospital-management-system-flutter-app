import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallButtonWidget extends StatelessWidget {
  CallButtonWidget(
      {super.key,
      required this.isVideoCall,
      required this.targetUserId,
      required this.targetUserName});

  bool isVideoCall;
  String targetUserId;
  String targetUserName;

  @override
  Widget build(BuildContext context) {
    return ZegoSendCallInvitationButton(
      padding: EdgeInsets.zero,
      iconSize: const Size(35, 35),
      margin: EdgeInsets.zero,
      buttonSize: const Size(35, 35),
      isVideoCall: isVideoCall,
      resourceID: "zego_call",
      invitees: [
        ZegoUIKitUser(
          id: targetUserId,
          name: targetUserName,
        ),
      ],
    );
  }
}
