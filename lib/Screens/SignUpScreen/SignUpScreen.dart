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
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
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
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                )),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            "assets/images/logo.png",
                          ),
                        ),
                        Text(
                          'Sign up for free',
                          style: TextStyle(
                              fontSize: height * appConstants.fontSize14,
                              fontWeight: FontWeight.w800),
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
                          textInputType: TextInputType.text,
                          textFieldWidth: MediaQuery.of(context).size.width,
                          haveText: true,
                          onValueChange: (value) {},
                          maxLines: 1,
                          borderCircular: 50,
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
                          textInputType: TextInputType.text,
                          isPassword: true,
                          textFieldWidth: MediaQuery.of(context).size.width,
                          haveText: true,
                          onValueChange: (value) {},
                          maxLines: 1,
                          borderCircular: 50,
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
                            Text(
                              "Remember Me",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * appConstants.fontSize14,
                                  color: Colors.black87),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonWidget(
                          buttonText: "Sign Up",
                          buttonWidth: MediaQuery.of(context).size.width,
                          buttonColor: Colors.blueAccent,
                          borderColor: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressedFunction: () async {
                            if (_formKey.currentState!.validate()) {
                              bool status = await appConstants
                                  .firebaseAuthServices
                                  .signUp(
                                      context: context,
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim());
                              if (status == true && context.mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  CustomPageRoute(child: SignInScreen()),
                                  (route) => false, // Close all existing routes
                                );
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Or Continue With",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: height * appConstants.fontSize14,
                              color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 20,
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
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * appConstants.fontSize14,
                                  color: Colors.black38),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      CustomPageRoute(child: SignInScreen()));
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          height * appConstants.fontSize14,
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
