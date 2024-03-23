import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/ButtonWidget.dart';
import '../../../Widgets/TextFieldWidget.dart';

class AddPharmacyDialogWidget extends StatefulWidget {
  AddPharmacyDialogWidget({super.key});

  @override
  State<AddPharmacyDialogWidget> createState() =>
      _AddPharmacyDialogWidgetState();
}

class _AddPharmacyDialogWidgetState extends State<AddPharmacyDialogWidget> {
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController ownerEmailController = TextEditingController();

  final TextEditingController ownerPasswordController = TextEditingController();

  final TextEditingController pharmacyNameController = TextEditingController();
  final TextEditingController pharmacyAddressController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

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
            children: [
              const Text(
                "Add Pharmacy",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                hintText: "Enter Owner Name",
                text: "Owner Name",
                controller: ownerNameController,
                isPassword: false,
                isEnabled: true,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Owner Name is required';
                  } else if (value.length < 5) {
                    return 'Owner name must have 5 characters';
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
                height: 20,
              ),
              TextFieldWidget(
                hintText: "Enter Owner Email",
                text: "Owner Email",
                controller: ownerEmailController,
                isPassword: false,
                isEnabled: true,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Owner Email is required';
                  } else if (value.length < 5) {
                    return 'Owner email must have 5 characters';
                  } else if (!value.contains("@")) {
                    return "Email is Invalid";
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
                height: 20,
              ),
              TextFieldWidget(
                hintText: "Enter Owner Password",
                text: "Password",
                controller: ownerPasswordController,
                isPassword: true,
                isEnabled: true,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Owner Password is required';
                  } else if (value.length < 5) {
                    return 'Owner Password must have 5 characters';
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
                height: 20,
              ),
              TextFieldWidget(
                hintText: "Enter Pharmacy Name",
                text: "Pharmacy",
                controller: pharmacyNameController,
                isPassword: false,
                isEnabled: true,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pharmacy Name is required';
                  } else if (value.length < 5) {
                    return 'Pharmacy name must have 5 characters';
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
                height: 20,
              ),
              TextFieldWidget(
                hintText: "Enter Pharmacy Address",
                text: "Address",
                controller: pharmacyAddressController,
                isPassword: false,
                isEnabled: true,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pharmacy Address is required';
                  } else if (value.length < 5) {
                    return 'Pharmacy address must have 5 characters';
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
                height: 20,
              ),
              const Text(
                "Please check owner and pharmacy detail again",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
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

                          await appConstants.pharmacyServices.addPharmacy(
                              ownerName: ownerNameController.text.trim(),
                              userEmail: ownerEmailController.text.trim(),
                              password: ownerPasswordController.text.trim(),
                              pharmacyName: pharmacyNameController.text.trim(),
                              pharmacyAddress:
                                  pharmacyAddressController.text.trim(),
                              context: context);

                          // await appConstants.medicineServices.add(
                          //     name: nameController.text.trim(),
                          //     quantity: quantityController.text.trim(),
                          //     context: context);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
