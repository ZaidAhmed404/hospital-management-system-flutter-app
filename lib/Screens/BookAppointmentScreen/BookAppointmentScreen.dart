import 'dart:developer';

import 'package:doctor_patient_management_system/cubit/LoadingCubit/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/MessageWidget.dart';
import '../../Widgets/PickDateWidget.dart';
import '../../Widgets/TextFieldWidget.dart';

class BookAppointmentScreen extends StatefulWidget {
  BookAppointmentScreen(
      {super.key, required this.onBackPressed, required this.doctorId});

  String doctorId;
  Function(int) onBackPressed;

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("${widget.doctorId}", name: "doctor id");
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  DateTime? _pickedDate;

  _selectDate() async {
    _pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2500));
    log("${_pickedDate!.day}-${_pickedDate!.month}-${_pickedDate!.year}");
  }

  String selectedSlot = "30 Minutes";

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
                    Row(
                      children: [
                        InkWell(
                          onTap: () => widget.onBackPressed(1),
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue.withOpacity(0.2)),
                              child: const Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.blue,
                              )),
                        ),
                        const Spacer(),
                        const Text(
                          "Book Appointment",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldWidget(
                      hintText: "Enter name",
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
                      height: 10,
                    ),
                    TextFieldWidget(
                      hintText: "Describe your problem",
                      text: "Problem",
                      controller: nameController,
                      isPassword: false,
                      isEnabled: true,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description is required';
                        } else if (value.length < 30) {
                          return 'Description must have 30 characters';
                        }
                        return null;
                      },
                      textInputType: TextInputType.text,
                      textFieldWidth: MediaQuery.of(context).size.width,
                      haveText: true,
                      onValueChange: (value) {},
                      maxLines: 10,
                      borderCircular: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PickDataWidget(onPressedFunction: _selectDate),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedSlot = "30 Minutes";
                            });
                          },
                          child: Container(
                            width: width * 0.4,
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            decoration: BoxDecoration(
                                color: (selectedSlot == "30 Minutes")
                                    ? Colors.blue
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blue)),
                            alignment: Alignment.center,
                            child: Text(
                              "30 Minutes",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: (selectedSlot == "30 Minutes")
                                      ? Colors.white
                                      : Colors.blue),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedSlot = "1 Hour";
                            });
                          },
                          child: Container(
                            width: width * 0.4,
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            decoration: BoxDecoration(
                                color: (selectedSlot == "1 Hour")
                                    ? Colors.blue
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blue)),
                            alignment: Alignment.center,
                            child: Text(
                              "1 Hour",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: (selectedSlot == "1 Hour")
                                      ? Colors.white
                                      : Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        buttonText: "Book",
                        buttonWidth: MediaQuery.of(context).size.width,
                        buttonColor: Colors.blueAccent,
                        borderColor: Colors.blueAccent,
                        textColor: Colors.white,
                        onPressedFunction: () async {
                          if (_pickedDate == null) {
                            if (context.mounted) {
                              messageWidget(
                                  context: context,
                                  isError: true,
                                  message: "Date is required");
                            }
                          } else if (_formKey.currentState!.validate()) {}
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
