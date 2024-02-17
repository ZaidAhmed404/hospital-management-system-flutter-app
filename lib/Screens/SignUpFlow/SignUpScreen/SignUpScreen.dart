import 'dart:developer';
import '../SignInScreen/SignInScreen.dart';
import 'package:doctor_patient_management_system/Widgets/MessageWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../Route/CustomPageRoute.dart';
import '../../../Widgets/ButtonWidget.dart';
import '../../../Widgets/IconTextWidget.dart';
import '../../../Widgets/TextFieldWidget.dart';
import '../../../cubit/LoadingCubit/loading_cubit.dart';
import '../../../main.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  bool? isChecked = false;

  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.98),
      body: BlocBuilder<LoadingCubit, LoadingState>(
        builder: (context, state) {
          return LoadingOverlay(
            isLoading: state.loading,
            color: Colors.black,
            opacity: 0.5,
            progressIndicator: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const CircularProgressIndicator()),
            child: SingleChildScrollView(
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
                          'Sign up for free',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                          hintText: "Email",
                          text: "Email",
                          controller: emailController,
                          isPassword: false,
                          isEnabled: true,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            } else if (value.length < 8) {
                              return 'Email must have 8 characters';
                            } else if (!value.contains("@") ||
                                !value.contains(".com")) {
                              return 'Please enter correct email';
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
                          isEnabled: true,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 8) {
                              return 'Password must have 8 characters';
                            }
                            return null;
                          },
                          isPassword: true,
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
                            buttonText: "Sign Up",
                            buttonColor: Colors.blueAccent,
                            borderColor: Colors.blueAccent,
                            textColor: Colors.white,
                            onPressedFunction: () {
                              if (_formKey.currentState!.validate()) {
                                appConstants.firebaseAuthServices.signUp(
                                    context: context,
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                              }
                            }),
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
                                try {
                                  appConstants.firebaseAuthServices
                                      .signInWithFacebook();
                                } catch (error) {
                                  messageWidget(
                                      context: context,
                                      isError: true,
                                      message: "$error");
                                }
                              },
                            ),
                            IconTextWidget(
                              iconUrl: "assets/icons/google.svg",
                              text: "Google",
                              onPressedFunction: () {
                                try {
                                  appConstants.firebaseAuthServices
                                      .signInWithGoogle();
                                } catch (error) {
                                  messageWidget(
                                      context: context,
                                      isError: true,
                                      message: "$error");
                                }
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
                              "Already have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.black38),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      CustomPageRoute(child: SignInScreen()));
                                },
                                child: const Text(
                                  "Sign In",
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
        },
      ),
    );
  }
}
