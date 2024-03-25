import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/Screens/AdminMedicineScreen/Widgets/EditMedicineDialogWidget.dart';
import 'package:doctor_patient_management_system/Widgets/ConfirmationDialogWidget.dart';
import 'package:flutter/material.dart';

import '../../Models/MedicineModel.dart';
import '../../main.dart';
import 'Widgets/AddMedicineDialogWidget.dart';

class AdminMedicineScreen extends StatelessWidget {
  AdminMedicineScreen(
      {super.key, required this.onBackPressed, required this.pharmacyId});

  String pharmacyId;
  Function() onBackPressed;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => onBackPressed(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Text(
                  "Medicines",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: height * appConstants.fontSize20),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                            insetPadding: const EdgeInsets.all(20),
                            child: AddMedicineDialogWidget(
                              pharmacyId: pharmacyId,
                            )));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.3,
                  child: Text(
                    "Name",
                    style: TextStyle(
                        fontSize: height * appConstants.fontSize14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Text(
                    "Quantity",
                    style: TextStyle(
                        fontSize: height * appConstants.fontSize14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                  child: Text(
                    "Action",
                    style: TextStyle(
                        fontSize: height * appConstants.fontSize14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('$pharmacyId.medicine')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  List<MedicineModel> medicineData =
                      snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;
                    return MedicineModel.fromMap(doc.id, data);
                  }).toList();
                  final documents = snapshot.data!.docs;
                  return SizedBox(
                    child: ListView.builder(
                      itemCount: medicineData.length,
                      itemBuilder: (context, index) {
                        MedicineModel medicine = medicineData[index];
                        return Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.3,
                                child: Text(
                                  medicine.name,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize:
                                          height * appConstants.fontSize14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.2,
                                child: Text(
                                  medicine.quantity,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize:
                                          height * appConstants.fontSize14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                  width: width * 0.3,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  Dialog(
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      child:
                                                          EditMedicineDialogWidget(
                                                        docId:
                                                            documents[index].id,
                                                        pharmacyId: pharmacyId,
                                                        name: medicine.name,
                                                        quantity:
                                                            medicine.quantity,
                                                        price: medicine.price,
                                                      )));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.green.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  Dialog(
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      child:
                                                          ConfirmationDialogWidget(
                                                        message:
                                                            'Are you sure, you want to delete this medicine?',
                                                        onCancelFunction: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        onConfirmFunction:
                                                            () async {
                                                          appConstants
                                                              .medicineServices
                                                              .delete(
                                                                  docId: documents[
                                                                          index]
                                                                      .id,
                                                                  context:
                                                                      context,
                                                                  pharmacyId:
                                                                      pharmacyId);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        title:
                                                            "Delete Medicine",
                                                      )));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.red.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
