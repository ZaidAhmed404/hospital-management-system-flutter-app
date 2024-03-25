import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Models/MedicineModel.dart';
import '../../../Models/PharmacyModel.dart';
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
      return MedicineModel.fromMap(data);
    }).toList();
    setState(() {
      isMedicineLoading = false;
      selectedMedicines.add(medicineData.isNotEmpty
          ? medicineData.first
          : MedicineModel(name: "", price: "", date: "", quantity: ""));
      if (medicineData.isNotEmpty) {}
    });
  }

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
                            });
                            medicineData = [];
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
                              name: "", price: "", date: "", quantity: ""));
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
                    ],
                  ),
                )
          ],
        ),
      ),
    );
  }
}
