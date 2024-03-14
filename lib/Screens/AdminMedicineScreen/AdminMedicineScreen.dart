import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/Screens/AdminMedicineScreen/Widgets/EditMedicineDialogWidget.dart';
import 'package:doctor_patient_management_system/Widgets/ConfirmationDialogWidget.dart';
import 'package:flutter/material.dart';

import '../../Models/MedicineModel.dart';
import '../../main.dart';
import 'Widgets/AddMedicineDialogWidget.dart';

class AdminMedicineScreen extends StatelessWidget {
  const AdminMedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Medicines",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                          insetPadding: const EdgeInsets.all(20),
                          child: AddMedicineDialogWidget()));
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
                child: const Text(
                  "Name",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: width * 0.2,
                child: const Text(
                  "Quantity",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: width * 0.3,
                child: const Text(
                  "Action",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
              stream:
                  FirebaseFirestore.instance.collection('medicine').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: Colors.blue,
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
                  return MedicineModel.fromMap(data);
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
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.2,
                              child: Text(
                                medicine.quantity,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
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
                                                      name: medicine.name,
                                                      quantity:
                                                          medicine.quantity,
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
                                                        Navigator.pop(context);
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
                                                                    context);
                                                        Navigator.pop(context);
                                                      },
                                                      title: "Delete Medicine",
                                                    )));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.2),
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
    );
  }
}
