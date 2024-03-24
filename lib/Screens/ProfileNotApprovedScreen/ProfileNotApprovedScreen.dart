import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Route/CustomPageRoute.dart';
import '../../Widgets/ButtonWidget.dart';
import '../../main.dart';
import '../SignInScreen/SignInScreen.dart';

class ProfileNotApprovedScreen extends StatelessWidget {
  const ProfileNotApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/pending.png",
            width: 200,
            height: 200,
          ),
        ),
        Center(
          child: Text(
            "Profile not Approved Yet",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: height * appConstants.fontSize18),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: ButtonWidget(
              buttonText: "Logout",
              buttonWidth: MediaQuery.of(context).size.width / 2,
              buttonColor: Colors.blueAccent,
              borderColor: Colors.blueAccent,
              textColor: Colors.white,
              onPressedFunction: () =>
                  appConstants.firebaseAuthServices.logout(context: context)),
        ),
      ],
    ));
  }
}
