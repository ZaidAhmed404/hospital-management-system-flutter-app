import 'dart:io';

import 'package:doctor_patient_management_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../Widgets/ButtonWidget.dart';
import '../../../Widgets/DropdownWidget.dart';
import '../../../Widgets/MessageWidget.dart';
import '../../../Widgets/TextFieldWidget.dart';
import '../../../cubit/LoadingCubit/loading_cubit.dart';
import '../BoardingScreen/BoardingScreen.dart';

class RegisterUserRoleScreen extends StatefulWidget {
  RegisterUserRoleScreen({
    super.key,
  });

  @override
  State<RegisterUserRoleScreen> createState() => _RegisterUserRoleScreenState();
}

const List<String> roles = <String>['Doctor', "Patient"];
const List<String> genders = <String>['Male', "Female", "Others"];

class _RegisterUserRoleScreenState extends State<RegisterUserRoleScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController doctorLicenseNumberController =
      TextEditingController();
  final TextEditingController doctorSpecializationController =
      TextEditingController();

  final TextEditingController cnicController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String imagePath = "";
  String role = roles.first;
  String gender = genders.first;
  File? image;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
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
              child: Container(
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
                                      size: const Size.fromRadius(
                                          48), // Image radius
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
                            } else if (value.length < 4) {
                              return 'User Name have  characters';
                            }
                            return null;
                          },
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          hintText: "00000-0000000-0",
                          text: "CNIC",
                          controller: cnicController,
                          isPassword: false,
                          isEnabled: true,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'CNIC is required';
                            } else if (value.length < 8) {
                              return 'CNIC must have 8 characters';
                            }
                            return null;
                          },
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          hintText: "Address",
                          text: "Address",
                          controller: addressController,
                          isPassword: false,
                          isEnabled: true,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Address is required';
                            } else if (value.length < 8) {
                              return 'Address must have 8 characters';
                            }
                            return null;
                          },
                          textInputType: TextInputType.text,
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
                              return 'Phone Number must have 5 characters';
                            }
                            return null;
                          },
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownWidget(
                            selectedValue: role,
                            list: roles,
                            title: "Role",
                            onPressedFunction: (value) {
                              setState(() {
                                role = value;
                              });
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownWidget(
                            selectedValue: gender,
                            list: genders,
                            title: "Gender",
                            onPressedFunction: (value) {
                              setState(() {
                                gender = value;
                              });
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        if (role == roles[0])
                          TextFieldWidget(
                            hintText: "Doctor License Number",
                            text: "Doctor License Number",
                            controller: doctorLicenseNumberController,
                            isPassword: false,
                            isEnabled: true,
                            validationFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Doctor License Number is required';
                              } else if (value.length < 5) {
                                return 'Doctor License Number must have 5 characters';
                              }
                              return null;
                            },
                            textInputType: TextInputType.text,
                          ),
                        if (role == roles[0])
                          const SizedBox(
                            height: 10,
                          ),
                        if (role == roles[0])
                          TextFieldWidget(
                            hintText: "Doctor Specialization",
                            text: "Doctor Specialization",
                            controller: doctorSpecializationController,
                            isPassword: false,
                            isEnabled: true,
                            validationFunction: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Doctor Specialization is required';
                              } else if (value.length < 5) {
                                return 'Doctor Specialization must have 5 characters';
                              }
                              return null;
                            },
                            textInputType: TextInputType.text,
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonWidget(
                            buttonText: "Save",
                            buttonWidth: MediaQuery.of(context).size.width,
                            buttonColor: Colors.blueAccent,
                            borderColor: Colors.blueAccent,
                            textColor: Colors.white,
                            onPressedFunction: () async {
                              if (imagePath == "") {
                                if (context.mounted) {
                                  messageWidget(
                                      context: context,
                                      isError: true,
                                      message: "User Photo required");
                                }
                              } else if (_formKey.currentState!.validate()) {
                                await appConstants.firebaseAuthServices
                                    .registerUserRole(
                                  context: context,
                                  photoPath: imagePath,
                                  displayName: nameController.text.trim(),
                                  cnic: cnicController.text.trim(),
                                  address: addressController.text.trim(),
                                  phoneNumber:
                                      phoneNumberController.text.trim(),
                                  role: role,
                                  gender: gender,
                                  doctorLicense:
                                      doctorLicenseNumberController.text.trim(),
                                  doctorSpecialization:
                                      doctorSpecializationController.text
                                          .trim(),
                                );
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
