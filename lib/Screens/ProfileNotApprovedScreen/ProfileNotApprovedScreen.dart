import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Route/CustomPageRoute.dart';
import '../../Widgets/ButtonWidget.dart';
import '../SignInScreen/SignInScreen.dart';

class ProfileNotApprovedScreen extends StatelessWidget {
  const ProfileNotApprovedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/pending.png",
          width: 200,
          height: 200,
        ),
        const Text(
          "Profile not Approved Yet",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
            buttonText: "Logout",
            buttonWidth: MediaQuery.of(context).size.width / 2,
            buttonColor: Colors.blueAccent,
            borderColor: Colors.blueAccent,
            textColor: Colors.white,
            onPressedFunction: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                CustomPageRoute(child: SignInScreen()),
                (route) => false,
              );
            }),
      ],
    ));
  }
}
