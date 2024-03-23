import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/ButtonWidget.dart';
import '../../../Widgets/TextFieldWidget.dart';

class EditPharmacyDialogWidget extends StatefulWidget {
  EditPharmacyDialogWidget({
    super.key,
    required this.docId,
    required this.name,
    required this.address,
  });

  String docId;
  String name;
  String address;

  @override
  State<EditPharmacyDialogWidget> createState() =>
      _EditPharmacyDialogWidgetState();
}

class _EditPharmacyDialogWidgetState extends State<EditPharmacyDialogWidget> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.name;
    addressController.text = widget.address;
  }

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
                "Edit Pharmacy Details",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                hintText: "Enter Pharmacy Name",
                text: "Name",
                controller: nameController,
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
                controller: addressController,
                isPassword: false,
                isEnabled: true,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pharmacy Address is required';
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
                          await appConstants.pharmacyServices.update(
                              docId: widget.docId,
                              name: nameController.text.trim(),
                              address: addressController.text.trim(),
                              context: context);

                          // await appConstants.medicineServices.update(
                          //     docId: widget.docId,
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
