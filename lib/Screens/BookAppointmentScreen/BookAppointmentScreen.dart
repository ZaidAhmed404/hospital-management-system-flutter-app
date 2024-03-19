import 'dart:developer';

import 'package:doctor_patient_management_system/cubit/LoadingCubit/loading_cubit.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/MessageWidget.dart';
import '../../Widgets/PickDateWidget.dart';
import '../../Widgets/PickTimeWidget.dart';
import '../../Widgets/TextFieldWidget.dart';
import 'Widgets/SelectTimeSlotWidget.dart';

class BookAppointmentScreen extends StatefulWidget {
  BookAppointmentScreen(
      {super.key,
      required this.onBackPressed,
      required this.doctorId,
      required this.doctorName,
      required this.doctorPhotoUrl});

  String doctorId;
  String doctorName;
  String doctorPhotoUrl;
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
    setState(() {});
  }

  TimeOfDay? _pickedTime;

  _selectTime() async {
    _pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {});
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      controller: descriptionController,
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
                    PickDataWidget(
                        onPressedFunction: _selectDate,
                        pickedDate: _pickedDate),
                    const SizedBox(
                      height: 10,
                    ),
                    SelectTimeSlotWidget(
                        selectedSlot: selectedSlot,
                        onSlotSelectedFunction: (value) {
                          setState(() {
                            selectedSlot = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    PickTimeWidget(
                        onPressedFunction: _selectTime,
                        pickedTime: _pickedTime),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const Text(
                    //   "Card Details",
                    //   style:
                    //       TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // CardFormField(
                    //   controller: CardFormEditController(),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        buttonText: "Book",
                        buttonWidth: width,
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
                          } else if (_pickedTime == null) {
                            if (context.mounted) {
                              messageWidget(
                                  context: context,
                                  isError: true,
                                  message: "Time is required");
                            }
                          } else if (_formKey.currentState!.validate()) {
                            appConstants.appointmentServices.addAppointment(
                                name: nameController.text.trim(),
                                date: _pickedDate!,
                                slot: selectedSlot,
                                time: _pickedTime!,
                                description: descriptionController.text.trim(),
                                doctorId: widget.doctorId,
                                doctorName: widget.doctorName,
                                doctorPhotoUrl: widget.doctorPhotoUrl,
                                context: context);
                            // appConstants.paymentServices
                            //     .makePayment(context: context);
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
