import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../Route/CustomPageRoute.dart';
import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/MessageWidget.dart';
import '../../Widgets/TextFieldWidget.dart';
import '../../cubit/loading/loading_cubit.dart';
import '../ResetPasswordScreen/ResetPasswordScreen.dart';
import 'Widgets/OPTInputWidget.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  String? _validate(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    }

    return null;
  }

  final dynamic _formKey = GlobalKey<FormState>();

  TextEditingController fieldOne = TextEditingController();

  TextEditingController fieldTwo = TextEditingController();

  TextEditingController fieldThree = TextEditingController();

  TextEditingController fieldFour = TextEditingController();

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
                          "Please enter registered Email, we will send the OTP.",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                        const Spacer(),
                        const Center(
                          child: Text(
                            "Code has been sent to ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OtpInputWidget(
                              controller: fieldOne,
                              autoFocus: true,
                            ), // auto focus
                            OtpInputWidget(
                                controller: fieldTwo, autoFocus: false),
                            OtpInputWidget(
                                controller: fieldThree, autoFocus: false),
                            OtpInputWidget(
                                controller: fieldFour, autoFocus: false),
                          ],
                        ),
                        const Spacer(),
                        ButtonWidget(
                            buttonText: "Continue",
                            buttonColor: Colors.blueAccent,
                            borderColor: Colors.blueAccent,
                            textColor: Colors.white,
                            onPressedFunction: () async {
                              if (fieldOne.text.isEmpty ||
                                  fieldTwo.text.isEmpty ||
                                  fieldThree.text.isEmpty ||
                                  fieldFour.text.isEmpty) {
                                if (context.mounted) {
                                  messageWidget(
                                      context: context,
                                      isError: true,
                                      message: "Please enter OTP");
                                }
                              } else {
                                await appConstants.firebaseAuthServices.verifyOtp(
                                    context: context,
                                    otp:
                                        "${fieldOne.text}${fieldTwo.text}${fieldThree.text}${fieldFour.text}");
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
