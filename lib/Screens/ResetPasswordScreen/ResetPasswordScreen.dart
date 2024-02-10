import 'package:flutter/material.dart';

import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/TextFieldWidget.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String? _validate(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    }

    return null;
  }

  bool? isChecked = false;

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.blue,
                      )),
                  const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const Text(
                "Create a new Password",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                hintText: "Password",
                text: "Password",
                controller: passwordController,
                isPassword: true,
                validationFunction: (value) {},
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                hintText: "Confirm Password",
                text: "Confirm Password",
                controller: confirmPasswordController,
                isPassword: true,
                validationFunction: (value) {},
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  const Text(
                    "Remember Me",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.black87),
                  )
                ],
              ),
              const Spacer(),
              ButtonWidget(
                  buttonText: "Save",
                  buttonColor: Colors.blueAccent,
                  borderColor: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressedFunction: () {}),
            ])),
      ),
    );
  }
}
