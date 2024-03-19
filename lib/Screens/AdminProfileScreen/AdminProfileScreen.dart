import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Route/CustomPageRoute.dart';
import '../../Widgets/ButtonWidget.dart';
import '../SignInScreen/SignInScreen.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(48),
                    child: Image.asset("assets/images/admin.png"),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Admin",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Text(
                    "Admin@gmail.com",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          ButtonWidget(
              buttonText: "Logout",
              buttonWidth: MediaQuery.of(context).size.width,
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
      ),
    );
  }
}
