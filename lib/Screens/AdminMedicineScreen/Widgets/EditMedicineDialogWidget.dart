import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/ButtonWidget.dart';
import '../../../Widgets/TextFieldWidget.dart';

class EditMedicineDialogWidget extends StatefulWidget {
  EditMedicineDialogWidget(
      {super.key,
      required this.docId,
      required this.quantity,
      required this.name,
      required this.price,
      required this.pharmacyId});

  String docId;
  String name;
  String quantity;
  String pharmacyId;
  String price;

  @override
  State<EditMedicineDialogWidget> createState() =>
      _EditMedicineDialogWidgetState();
}

class _EditMedicineDialogWidgetState extends State<EditMedicineDialogWidget> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController quantityController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.name;
    quantityController.text = widget.quantity;
    priceController.text = widget.price;
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
                "Edit Medicine Details",
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
                          await appConstants.medicineServices.update(
                              docId: widget.docId,
                              pharmacyId: widget.pharmacyId,
                              name: nameController.text.trim(),
                              price: priceController.text.trim(),
                              quantity: quantityController.text.trim(),
                              context: context);
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
