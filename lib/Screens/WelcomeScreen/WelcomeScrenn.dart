import 'package:flutter/material.dart';

import '../../Route/CustomPageRoute.dart';
import '../../Widgets/ButtonWidget.dart';
import '../SignInScreen/SignInScreen.dart';
import '../SignUpScreen/SignUpScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Welcome to DoctorQ!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonWidget(
              buttonText: "Sign Up",
              buttonColor: Colors.blueAccent,
              borderColor: Colors.blueAccent,
              textColor: Colors.white,
              onPressedFunction: () {
                Navigator.of(context)
                    .push(CustomPageRoute(child: SignUpScreen()));
              }),
          const SizedBox(
            height: 10,
          ),
          ButtonWidget(
              buttonText: "Sign In",
              buttonColor: Colors.white,
              borderColor: Colors.blueAccent,
              textColor: Colors.blueAccent,
              onPressedFunction: () {
                Navigator.of(context)
                    .push(CustomPageRoute(child: SignInScreen()));
              }),
        ],
      ),
    );
  }
}
