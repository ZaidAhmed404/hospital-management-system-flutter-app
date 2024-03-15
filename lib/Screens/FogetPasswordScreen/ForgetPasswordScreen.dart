import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../Route/CustomPageRoute.dart';
import '../../../Widgets/ButtonWidget.dart';
import '../../../Widgets/TextFieldWidget.dart';
import '../../../cubit/LoadingCubit/loading_cubit.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final dynamic _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

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
                              'Forgot Password',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        const Text(
                          "Please enter registered Email, we will send the reset password email",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Form(
                          key: _formKey,
                          child: TextFieldWidget(
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
                        ),
                        const Spacer(flex: 3),
                        ButtonWidget(
                            buttonText: "Continue",
                            buttonWidth: MediaQuery.of(context).size.width,
                            buttonColor: Colors.blueAccent,
                            borderColor: Colors.blueAccent,
                            textColor: Colors.white,
                            onPressedFunction: () async {
                              if (_formKey.currentState!.validate()) {
                                await appConstants.firebaseAuthServices
                                    .sendEmail(
                                        context: context,
                                        email: emailController.text.trim());
                              }
                            }),
                      ])),
            );
          },
        ),
      ),
    );
  }
}
