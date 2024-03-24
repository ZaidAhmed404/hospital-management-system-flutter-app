import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Models/DoctorModel.dart';
import '../../Models/PatientModel.dart';
import '../../cubit/DoctorCubit/doctor_cubit.dart';
import '../../cubit/UserCubit/user_cubit.dart';
import '../../cubit/patient/patient_cubit.dart';
import '../BoardingScreen/BoardingScreen.dart';
import '../LandingScreen/LandingScreen.dart';
import '../RegisterUserRoleScreen/RegisterUserRolesScreen.dart';
import '../SignUpScreen/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../Route/CustomPageRoute.dart';
import '../../../Widgets/ButtonWidget.dart';
import '../../../Widgets/IconTextWidget.dart';
import '../../../Widgets/MessageWidget.dart';
import '../../../Widgets/TextFieldWidget.dart';
import '../../../cubit/LoadingCubit/loading_cubit.dart';
import '../../../main.dart';
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                child: const CircularProgressIndicator()),
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
                          'Sign in your account',
                          style: TextStyle(
                              fontSize: height * appConstants.fontSize16,
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
                          isPassword: true,
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
                            buttonText: "Sign In",
                            buttonWidth: MediaQuery.of(context).size.width,
                            buttonColor: Colors.blueAccent,
                            borderColor: Colors.blueAccent,
                            textColor: Colors.white,
                            onPressedFunction: () async {
                              if (_formKey.currentState!.validate()) {
                                await appConstants.firebaseAuthServices
                                    .userLogin(
                                        context: context,
                                        emailAddress:
                                            emailController.text.trim(),
                                        password:
                                            passwordController.text.trim());
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          child: Text(
                            "Forgot the password?",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: height * appConstants.fontSize14,
                                color: Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                                CustomPageRoute(child: ForgetPasswordScreen()));
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
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * appConstants.fontSize14,
                                  color: Colors.black38),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      CustomPageRoute(child: SignUpScreen()));
                                },
                                child: Text(
                                  "Sign Up",
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
