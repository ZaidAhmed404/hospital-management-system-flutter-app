import 'package:flutter/material.dart';

import '../../../Route/CustomPageRoute.dart';
import '../../../Widgets/ButtonWidget.dart';
import '../../../Widgets/TextFieldWidget.dart';
import '../OtpScreen/OtpScreen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  String? _validate(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    }

    return null;
  }

  final dynamic _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

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
                    'Forgot Password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                  validationFunction: (value) {},
                ),
              ),
              const Spacer(flex: 3),
              ButtonWidget(
                  buttonText: "Continue",
                  buttonColor: Colors.blueAccent,
                  borderColor: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressedFunction: () {
                    Navigator.of(context)
                        .push(CustomPageRoute(child: OtpScreen()));
                  }),
            ])),
      ),
    );
  }
}
