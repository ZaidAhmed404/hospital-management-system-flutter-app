import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/TextFieldWidget.dart';
import '../../cubit/loading/loading_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool? isChecked = false;

  final TextEditingController passwordController = TextEditingController();
  final dynamic _formKey = GlobalKey<FormState>();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LoadingCubit, LoadingState>(
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
              child: Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
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
                          const SizedBox(
                            height: 20,
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
                              } else if (passwordController.text !=
                                  confirmPasswordController.text) {
                                return "Password and confirm password should match";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldWidget(
                            hintText: "Confirm Password",
                            text: "Confirm Password",
                            controller: confirmPasswordController,
                            isPassword: true,
                            validationFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm Password is required';
                              } else if (value.length < 8) {
                                return 'Confirm Password must have 8 characters';
                              } else if (passwordController.text !=
                                  confirmPasswordController.text) {
                                return "Password and confirm password should match";
                              }
                              return null;
                            },
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
                              onPressedFunction: () {
                                if (_formKey.currentState!.validate()) {}
                              }),
                        ]),
                  )),
            );
          },
        ),
      ),
    );
  }
}
