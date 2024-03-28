import 'package:doctor_patient_management_system/cubit/LoadingCubit/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/TextFieldWidget.dart';
import '../../main.dart';

class SendUsMessageScreen extends StatefulWidget {
  SendUsMessageScreen({super.key, required this.backPressedFunction});

  Function(int) backPressedFunction;

  @override
  State<SendUsMessageScreen> createState() => _SendUsMessageScreenState();
}

class _SendUsMessageScreenState extends State<SendUsMessageScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController subjectController = TextEditingController();

  final TextEditingController messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<LoadingCubit, LoadingState>(
      builder: (context, state) {
        return LoadingOverlay(
          isLoading: state.loading,
          color: Colors.black,
          opacity: 0.5,
          progressIndicator: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const CircularProgressIndicator(
                color: Colors.blue,
              )),
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8)),
                          child: IconButton(
                              onPressed: () => widget.backPressedFunction(0),
                              icon: const Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.blue,
                              )),
                        ),
                        const Spacer(),
                        Text(
                          "Send Us Message",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: height * appConstants.fontSize20),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldWidget(
                      hintText: "Name",
                      text: "Name",
                      controller: nameController,
                      isPassword: false,
                      isEnabled: true,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        } else if (value.length < 5) {
                          return 'Name must have 5 characters';
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
                      height: 30,
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
                      height: 30,
                    ),
                    TextFieldWidget(
                      hintText: "Subject",
                      text: "Subject",
                      controller: subjectController,
                      isPassword: false,
                      isEnabled: true,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Subject is required';
                        } else if (value.length < 8) {
                          return 'Subject must have 8 characters';
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
                      height: 30,
                    ),
                    TextFieldWidget(
                      hintText: "Message",
                      text: "Message",
                      controller: messageController,
                      isPassword: false,
                      isEnabled: true,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Message is required';
                        } else if (value.length < 30) {
                          return 'Email must have 30 characters';
                        }
                        return null;
                      },
                      textInputType: TextInputType.text,
                      textFieldWidth: MediaQuery.of(context).size.width,
                      haveText: true,
                      onValueChange: (value) {},
                      maxLines: 5,
                      borderCircular: 10,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                        buttonText: "Send",
                        buttonWidth: MediaQuery.of(context).size.width,
                        buttonColor: Colors.blueAccent,
                        borderColor: Colors.blueAccent,
                        textColor: Colors.white,
                        onPressedFunction: () async {
                          if (_formKey.currentState!.validate()) {
                            await appConstants.commonServices.addSendUsMessage(
                                context: context,
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                subject: subjectController.text.trim(),
                                message: messageController.text.trim());

                            setState(() {
                              nameController.text = "";
                              emailController.text = "";
                              subjectController.text = "";
                              messageController.text = "";
                            });
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
