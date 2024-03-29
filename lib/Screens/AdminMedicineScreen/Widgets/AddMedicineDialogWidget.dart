import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/ButtonWidget.dart';
import '../../../Widgets/TextFieldWidget.dart';

class AddMedicineDialogWidget extends StatefulWidget {
  AddMedicineDialogWidget({super.key, required this.pharmacyId});

  String pharmacyId;

  @override
  State<AddMedicineDialogWidget> createState() =>
      _AddMedicineDialogWidgetState();
}

class _AddMedicineDialogWidgetState extends State<AddMedicineDialogWidget> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

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
                "Add Medicines",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                hintText: "Enter Medicine Name",
                text: "Medicine",
                controller: nameController,
                isPassword: false,
                isEnabled: true,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Medicine Name is required';
                  } else if (value.length < 5) {
                    return 'Medicine name must have 5 characters';
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
                hintText: "Enter Medicine Quantity",
                text: "Quantity",
                controller: quantityController,
                isPassword: false,
                isEnabled: true,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Medicine Quantity is required';
                  }
                  return null;
                },
                textInputType: TextInputType.number,
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
                hintText: "Enter Medicine Price Per Unit",
                text: "Price",
                controller: priceController,
                isPassword: false,
                isEnabled: true,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price Per Unit is required';
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                textFieldWidth: MediaQuery.of(context).size.width,
                haveText: true,
                onValueChange: (value) {},
                maxLines: 1,
                borderCircular: 50,
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
                          await appConstants.medicineServices.add(
                              name: nameController.text.trim(),
                              quantity: quantityController.text.trim(),
                              pharmacyId: widget.pharmacyId,
                              price: priceController.text.trim(),
                              context: context);
                          setState(() {
                            isLoading = false;
                          });
                          // await appConstants.firebaseAuthServices
                          //     .userLogin(
                          //     context: context,
                          //     emailAddress:
                          //     emailController.text.trim(),
                          //     password:
                          //     passwordController.text.trim());
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
