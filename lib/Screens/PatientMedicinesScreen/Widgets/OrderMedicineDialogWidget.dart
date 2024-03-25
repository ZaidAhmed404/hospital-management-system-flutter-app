import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Models/MedicineModel.dart';
import '../../../Models/PharmacyModel.dart';
import '../../../Widgets/ButtonWidget.dart';
import '../../../Widgets/TextFieldWidget.dart';
import '../../../main.dart';

class OrderMedicineDialogWidget extends StatefulWidget {
  const OrderMedicineDialogWidget({super.key});

  @override
  State<OrderMedicineDialogWidget> createState() =>
      _OrderMedicineDialogWidgetState();
}

class _OrderMedicineDialogWidgetState extends State<OrderMedicineDialogWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPharmacies();
  }

  List<PharmacyModel> pharmacyData = [];

  List<MedicineModel> medicineData = [];

  bool isPharmacyLoading = false;
  PharmacyModel? selectedPharmacy;

  List<MedicineModel?> selectedMedicines = [];

  Future<void> getAllPharmacies() async {
    setState(() {
      isPharmacyLoading = true;
    });

    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('pharmacies').get();

    pharmacyData = snapshot.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return PharmacyModel.fromJson(data);
    }).toList();

    setState(() {
      isPharmacyLoading = false;
      selectedPharmacy = pharmacyData.isNotEmpty
          ? pharmacyData.first
          : PharmacyModel(name: "", address: "", date: "", ownerId: "");
    });
    await getPharmacyMedicines();
  }

  bool isMedicineLoading = false;

  getPharmacyMedicines() async {
    setState(() {
      isMedicineLoading = true;
    });

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('${selectedPharmacy?.ownerId}.medicine')
        .get();

    medicineData = snapshot.docs.map((DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      return MedicineModel.fromMap(doc.id, data);
    }).toList();
    setState(() {
      isMedicineLoading = false;
      selectedMedicines.add(medicineData.isNotEmpty
          ? medicineData.first
          : MedicineModel(
              docId: "", name: "", price: "", date: "", quantity: ""));
      amountController.add(TextEditingController());
    });
  }

  List<TextEditingController> amountController = [];
  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  List<Map> data = [];
  int medicineCount = 1;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Medicines",
                style: TextStyle(
                    fontSize: height * appConstants.fontSize20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
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
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                textFieldWidth: MediaQuery.of(context).size.width,
                haveText: true,
                onValueChange: (value) {
                  setState(() {});
                },
                maxLines: 1,
                borderCircular: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                hintText: "Enter address",
                text: "Address",
                controller: addressController,
                isPassword: false,
                isEnabled: true,
                validationFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                textFieldWidth: MediaQuery.of(context).size.width,
                haveText: true,
                onValueChange: (value) {
                  setState(() {});
                },
                maxLines: 1,
                borderCircular: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              isPharmacyLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.blue,
                    ))
                  : pharmacyData.isEmpty
                      ? Center(
                          child: Text(
                            "No Pharmacy Found",
                            style: TextStyle(
                                fontSize: height * appConstants.fontSize20,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.black12),
                              borderRadius: BorderRadius.circular(50)),
                          child: DropdownButton<PharmacyModel>(
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            value: selectedPharmacy,
                            icon: const Icon(Icons.arrow_drop_down_outlined),
                            onChanged: (PharmacyModel? value) async {
                              setState(() {
                                selectedPharmacy = value!;
                                medicineCount = 1;
                                medicineData = [];
                                selectedMedicines = [];
                              });

                              await getPharmacyMedicines();
                            },
                            isExpanded: true,
                            underline: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            items: pharmacyData
                                .map<DropdownMenuItem<PharmacyModel>>(
                                    (PharmacyModel value) {
                              return DropdownMenuItem<PharmacyModel>(
                                value: value,
                                child: Text(value.name),
                              );
                            }).toList(),
                          ),
                        ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Medicine",
                    style: TextStyle(
                        fontSize: height * appConstants.fontSize20,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (medicineCount > 1) {
                        setState(() {
                          medicineCount--;
                        });
                        amountController.removeLast();
                        selectedMedicines.removeLast();
                      }
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue.withOpacity(0.2)),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.blue,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        medicineCount++;
                        selectedMedicines.add(medicineData.isNotEmpty
                            ? medicineData.first
                            : MedicineModel(
                                docId: "",
                                name: "",
                                price: "",
                                date: "",
                                quantity: ""));
                        amountController.add(TextEditingController());
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue.withOpacity(0.2)),
                        child: const Icon(
                          Icons.add,
                          color: Colors.blue,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (isMedicineLoading)
                const Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                )),
              if (isMedicineLoading == false && medicineData.isNotEmpty)
                for (int index = 0; index < medicineCount; index++)
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.black12),
                              borderRadius: BorderRadius.circular(50)),
                          child: DropdownButton<MedicineModel>(
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            value: selectedMedicines[index],
                            icon: const Icon(Icons.arrow_drop_down_outlined),
                            onChanged: (MedicineModel? value) {
                              setState(() {
                                selectedMedicines[index] = value!;
                              });
                            },
                            isExpanded: true,
                            underline: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            items: medicineData
                                .map<DropdownMenuItem<MedicineModel>>(
                                    (MedicineModel value) {
                              return DropdownMenuItem<MedicineModel>(
                                value: value,
                                child: Text(value.name),
                              );
                            }).toList(),
                          ),
                        ),
                        TextFieldWidget(
                          hintText: "Amount",
                          text: "Amount",
                          controller: amountController[index],
                          isPassword: false,
                          isEnabled: true,
                          validationFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Amount is required';
                            }
                            return null;
                          },
                          textInputType: TextInputType.number,
                          textFieldWidth:
                              MediaQuery.of(context).size.width * 0.3,
                          haveText: false,
                          onValueChange: (value) {
                            setState(() {});
                          },
                          maxLines: 1,
                          borderCircular: 50,
                        ),
                        if (amountController[index].text.isNotEmpty)
                          Expanded(
                            child: Text(
                                "Rs.${(int.parse(amountController[index].text)) * int.parse(selectedMedicines[index]!.price)}"),
                          )
                      ],
                    ),
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
                      buttonText: "Order",
                      buttonWidth: MediaQuery.of(context).size.width,
                      buttonColor: Colors.blueAccent,
                      borderColor: Colors.blueAccent,
                      textColor: Colors.white,
                      onPressedFunction: () async {
                        if (_formKey.currentState!.validate() &&
                            selectedPharmacy?.ownerId != "") {
                          List<Map> data = [];
                          double totalBill = 0;
                          for (int index = 0; index < medicineCount; index++) {
                            if (amountController[index].text.isNotEmpty) {
                              data.add({
                                "medicineDocId":
                                    selectedMedicines[index]!.docId,
                                "name": selectedMedicines[index]!.name,
                                "quantity": amountController[index].text,
                                "price": int.parse(
                                        amountController[index].text) *
                                    int.parse(selectedMedicines[index]!.price)
                              });
                              totalBill = totalBill +
                                  int.parse(amountController[index].text) *
                                      int.parse(
                                          selectedMedicines[index]!.price);
                            }
                          }
                          setState(() {
                            isLoading = true;
                          });
                          if (context.mounted) {
                            bool state = await appConstants.paymentServices
                                .makePayment(context: context);
                            if (context.mounted && state == true) {
                              await appConstants.medicineServices.orderMedicine(
                                  name: nameController.text.trim(),
                                  medicines: data,
                                  address: addressController.text.trim(),
                                  ownerId: selectedPharmacy!.ownerId,
                                  total: totalBill.toString(),
                                  context: context);
                            }
                          }
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
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
