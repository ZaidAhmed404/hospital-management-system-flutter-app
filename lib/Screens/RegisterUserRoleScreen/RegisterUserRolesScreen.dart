import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/DropdownWidget.dart';
import '../../Widgets/TextFieldWidget.dart';

class RegisterUserRoleScreen extends StatefulWidget {
  RegisterUserRoleScreen({super.key});

  @override
  State<RegisterUserRoleScreen> createState() => _RegisterUserRoleScreenState();
}

const List<String> roles = <String>['Doctor', "Patient"];

class _RegisterUserRoleScreenState extends State<RegisterUserRoleScreen> {
  final TextEditingController emailController =
      TextEditingController(text: "dummy");

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController cnicController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String imagePath = "";
  String role = roles.first;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.98),
        body: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        try {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);

                          if (image == null) return;

                          imagePath = image.path;
                          setState(() {});
                        } on PlatformException {}
                      },
                      child: imagePath != ""
                          ? ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(48), // Image radius
                                child: Image.file(
                                  File(
                                    imagePath,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  padding: const EdgeInsets.all(5),
                                  child: SvgPicture.asset(
                                    "assets/icons/profile.svg",
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle),
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 15,
                                      )),
                                )
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    hintText: "User Name",
                    text: "User Name",
                    controller: nameController,
                    isPassword: false,
                    isEnabled: true,
                    validationFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'User Name is required';
                      } else if (value.length < 5) {
                        return 'User Name have 5 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    hintText: "00000-0000000-0",
                    text: "CNIC",
                    controller: cnicController,
                    isPassword: false,
                    isEnabled: false,
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
                    hintText: "Email",
                    text: "Email",
                    controller: emailController,
                    isPassword: false,
                    isEnabled: false,
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
                    hintText: "Phone Number",
                    text: "Phone Number",
                    controller: phoneNumberController,
                    isPassword: false,
                    isEnabled: true,
                    validationFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number is required';
                      } else if (value.length < 5) {
                        return 'Phone Number have 5 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownWidget(
                      selectedValue: role,
                      list: roles,
                      onPressedFunction: (value) {
                        setState(() {
                          role = value;
                        });
                      }),
                  if (role == roles[0])
                    const SizedBox(
                      height: 10,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                      buttonText: "Save",
                      buttonColor: Colors.blueAccent,
                      borderColor: Colors.blueAccent,
                      textColor: Colors.white,
                      onPressedFunction: () {
                        if (_formKey.currentState!.validate()) {}
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
