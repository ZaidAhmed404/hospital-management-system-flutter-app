import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'ButtonWidget.dart';
import 'TextFieldWidget.dart';

class RateDoctorDialogWidget extends StatefulWidget {
  RateDoctorDialogWidget({super.key, required this.doctorId});

  String doctorId;

  @override
  State<RateDoctorDialogWidget> createState() => _RateDoctorDialogWidgetState();
}

class _RateDoctorDialogWidgetState extends State<RateDoctorDialogWidget> {
  final TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  double rate = 3;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Rate Doctor",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    rate = rating;
                    print(rating);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                hintText: "Describe your experience",
                text: "Describe your experience",
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
                height: 20,
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : ButtonWidget(
                      buttonText: "Save",
                      buttonWidth: MediaQuery.of(context).size.width,
                      buttonColor: Colors.blueAccent,
                      borderColor: Colors.blueAccent,
                      textColor: Colors.white,
                      onPressedFunction: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          await appConstants.commonServices.rateDoctor(
                              context: context,
                              doctorId: widget.doctorId,
                              rate: rate.toString(),
                              description: descriptionController.text.trim());

                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pop(context);
                        }
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
