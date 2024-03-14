import 'dart:developer';
import 'dart:io';

import 'package:doctor_patient_management_system/Models/PatientModel.dart';
import 'package:doctor_patient_management_system/cubit/DoctorCubit/doctor_cubit.dart';
import 'package:doctor_patient_management_system/cubit/LoadingCubit/loading_cubit.dart';
import 'package:doctor_patient_management_system/cubit/UserCubit/user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../Models/DoctorModel.dart';
import '../../../Models/UserModel.dart';
import '../../../Widgets/ButtonWidget.dart';
import '../../../Widgets/DropdownWidget.dart';
import '../../../Widgets/MessageWidget.dart';
import '../../../Widgets/TextFieldWidget.dart';
import '../../../main.dart';
import '../SignInScreen/SignInScreen.dart';

class EditProfileScreen extends StatefulWidget {
  PatientModel? patientModel;
  UserModel userModel;
  DoctorModel? doctorModel;
  Function(int) backPressedFunction;

  EditProfileScreen(
      {super.key,
      this.patientModel,
      this.doctorModel,
      required this.userModel,
      required this.backPressedFunction});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

const List<String> genders = <String>['Male', "Female", "Others"];

String gender = genders.first;

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String imagePath = "";
  final TextEditingController nameController = TextEditingController();
  bool isEnabled = true;
  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController cnicController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController doctorLicenseNumberController =
      TextEditingController();
  final TextEditingController doctorSpecializationController =
      TextEditingController();

  final TextEditingController cardController = TextEditingController();
  final TextEditingController doctorHourlyRateController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.userModel.displayName;
    if (appConstants.role == "patient") {
      log("message");
      phoneNumberController.text = widget.patientModel!.phoneNumber;
      cnicController.text = widget.patientModel!.cnic;
      addressController.text = widget.patientModel!.address;
      cardController.text = widget.patientModel!.cardNumber;
      // gender = widget.patientModel!.gender;
    } else {
      log("here");
      phoneNumberController.text = widget.doctorModel!.phoneNumber;
      cnicController.text = widget.doctorModel!.cnic;
      addressController.text = widget.doctorModel!.address;
      // gender = widget.doctorModel!.gender;
      doctorLicenseNumberController.text = widget.doctorModel!.licenseNumber;
      doctorSpecializationController.text = widget.doctorModel!.specialization;
      cardController.text = widget.doctorModel!.cardNumber;
      doctorHourlyRateController.text = widget.doctorModel!.hourlyRate;
    }
    log(phoneNumberController.text, name: "phone number");
    log(cnicController.text, name: "cnic");
  }

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
                        const Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        const Spacer(),
                      ],
                    ),
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
                                  size:
                                      const Size.fromRadius(48), // Image radius
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
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(48),
                                        child: Image.network(
                                          widget.userModel.photoUrl,
                                          frameBuilder:
                                              (context, child, frame, was) {
                                            return child;
                                          },
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                                child: SizedBox(
                                                    width: 70,
                                                    height: 70,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child:
                                                          const CircularProgressIndicator(
                                                        color:
                                                            Color(0xff3FA8F9),
                                                      ),
                                                    )));
                                          },
                                          fit: BoxFit.fill,
                                          width: width * 0.75,
                                        ),
                                      ),
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
                      isEnabled: isEnabled,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'User Name is required';
                        } else if (value.length < 4) {
                          return 'User Name have  characters';
                        }
                        return null;
                      },
                      textInputType: TextInputType.text,
                      textFieldWidth: MediaQuery.of(context).size.width,
                      haveText: true,
                      onValueChange: (value) {},
                    ),
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
                    TextFieldWidget(
                      hintText: "Phone Number",
                      text: "Phone Number",
                      controller: phoneNumberController,
                      isPassword: false,
                      isEnabled: isEnabled,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone Number is required';
                        } else if (value.length < 8) {
                          return 'Phone Number must have 8 characters';
                        }
                        return null;
                      },
                      textInputType: TextInputType.number,
                      textFieldWidth: MediaQuery.of(context).size.width,
                      haveText: true,
                      onValueChange: (value) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: "00000-0000000-0",
                      text: "CNIC",
                      controller: cnicController,
                      isPassword: false,
                      isEnabled: isEnabled,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'CNIC is required';
                        } else if (value.length < 8) {
                          return 'CNIC must have 8 characters';
                        }
                        return null;
                      },
                      textInputType: TextInputType.number,
                      textFieldWidth: MediaQuery.of(context).size.width,
                      haveText: true,
                      onValueChange: (value) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: "Address",
                      text: "Address",
                      controller: addressController,
                      isPassword: false,
                      isEnabled: isEnabled,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Address is required';
                        } else if (value.length < 8) {
                          return 'Address must have 8 characters';
                        }
                        return null;
                      },
                      textInputType: TextInputType.text,
                      textFieldWidth: MediaQuery.of(context).size.width,
                      haveText: true,
                      onValueChange: (value) {},
                    ),
                    if (appConstants.role == "doctor")
                      const SizedBox(
                        height: 10,
                      ),
                    if (appConstants.role == "doctor")
                      TextFieldWidget(
                        hintText: "License Number",
                        text: "License Number",
                        controller: doctorLicenseNumberController,
                        isPassword: false,
                        isEnabled: isEnabled,
                        validationFunction: (value) {
                          if (value == null || value.isEmpty) {
                            return 'License is required';
                          } else if (value.length < 8) {
                            return 'License must have 8 characters';
                          }
                          return null;
                        },
                        textInputType: TextInputType.number,
                        textFieldWidth: MediaQuery.of(context).size.width,
                        haveText: true,
                        onValueChange: (value) {},
                      ),
                    if (appConstants.role == "doctor")
                      const SizedBox(
                        height: 10,
                      ),
                    if (appConstants.role == "doctor")
                      TextFieldWidget(
                        hintText: "Specialization",
                        text: "Specialization",
                        controller: doctorSpecializationController,
                        isPassword: false,
                        isEnabled: isEnabled,
                        validationFunction: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Specialization is required';
                          } else if (value.length < 4) {
                            return 'Specialization must have 4 characters';
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        textFieldWidth: MediaQuery.of(context).size.width,
                        haveText: true,
                        onValueChange: (value) {},
                      ),
                    if (appConstants.role == "doctor")
                      const SizedBox(
                        height: 10,
                      ),
                    if (appConstants.role == "doctor")
                      TextFieldWidget(
                        hintText: "Hourly Rate",
                        text: "Hourly Rate",
                        controller: doctorHourlyRateController,
                        isPassword: false,
                        isEnabled: true,
                        validationFunction: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Hourly Rate is required';
                          }
                          return null;
                        },
                        textInputType: TextInputType.number,
                        textFieldWidth: MediaQuery.of(context).size.width,
                        haveText: true,
                        onValueChange: (value) {},
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: "0000-0000-0000-0000",
                      text: "Card Number",
                      controller: cardController,
                      isPassword: false,
                      isEnabled: true,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Card Number is required';
                        } else if (value.length < 16) {
                          return 'Card Number must have 16 characters';
                        }
                        return null;
                      },
                      textInputType: TextInputType.number,
                      textFieldWidth: MediaQuery.of(context).size.width,
                      haveText: true,
                      onValueChange: (value) {},
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
                        onPressedFunction: () {
                          if (_formKey.currentState!.validate()) {
                            if (appConstants.role == "doctor") {
                              appConstants.doctorServices.updateDoctorData(
                                  context: context,
                                  photoPath: imagePath,
                                  name: nameController.text.trim(),
                                  cnic: cnicController.text.trim(),
                                  address: addressController.text.trim(),
                                  phoneNumber:
                                      phoneNumberController.text.trim(),
                                  licenseNumber:
                                      doctorLicenseNumberController.text.trim(),
                                  specialization: doctorSpecializationController
                                      .text
                                      .trim(),
                                  gender: gender,
                                  cardNumber: cardController.text.trim(),
                                  hourlyRate:
                                      doctorHourlyRateController.text.trim());
                            } else {
                              appConstants.patientServices.updatePatientData(
                                  context: context,
                                  photoPath: imagePath,
                                  name: nameController.text.trim(),
                                  phoneNumber:
                                      phoneNumberController.text.trim(),
                                  cnic: cnicController.text.trim(),
                                  address: addressController.text.trim(),
                                  gender: gender,
                                  cardNumber: cardController.text.trim());
                            }
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
    );
  }
}
