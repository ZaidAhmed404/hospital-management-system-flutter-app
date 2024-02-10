import 'dart:developer';

import 'package:doctor_patient_management_system/Screens/SignUpScreen/SignUpScreen.dart';
import 'package:flutter/material.dart';

import '../../Route/CustomPageRoute.dart';
import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/IconTextWidget.dart';
import '../../Widgets/TextFieldWidget.dart';
import '../FogetPasswordScreen/ForgetPasswordScreen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();

  bool? isChecked = false;

  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.98),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Sign in your account',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    hintText: "Email",
                    text: "Email",
                    controller: emailController,
                    isPassword: false,
                    validationFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (value.length < 8) {
                        return 'Email must have 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    hintText: "Password",
                    text: "Password",
                    controller: passwordController,
                    isPassword: true,
                    validationFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 8) {
                        return 'Password must have 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                      buttonText: "Sign In",
                      buttonColor: Colors.blueAccent,
                      borderColor: Colors.blueAccent,
                      textColor: Colors.white,
                      onPressedFunction: () {
                        if (_formKey.currentState!.validate()) {}
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    child: const Text(
                      "Forgot the password?",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(CustomPageRoute(child: ForgetPasswordScreen()));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Or Continue With",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconTextWidget(
                        iconUrl: "assets/icons/facebook.svg",
                        text: "Facebook",
                        onPressedFunction: () {
                          log("message");
                        },
                      ),
                      IconTextWidget(
                        iconUrl: "assets/icons/google.svg",
                        text: "Google",
                        onPressedFunction: () {
                          log("message");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Or Continue With",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.black38),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(CustomPageRoute(child: SignUpScreen()));
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.blue),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
