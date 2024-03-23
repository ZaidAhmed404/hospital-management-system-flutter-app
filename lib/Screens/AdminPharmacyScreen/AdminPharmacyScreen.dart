import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/Screens/AdminPharmacyScreen/Widgets/EditPharmacyDialogWidget.dart';
import 'package:flutter/material.dart';

import '../../Models/PharmacyModel.dart';
import '../../Widgets/ConfirmationDialogWidget.dart';
import '../../main.dart';
import '../AdminMedicineScreen/AdminMedicineScreen.dart';
import 'Widgets/AddPharmacyDialogWidget.dart';

class AdminPharmacyScreen extends StatefulWidget {
  const AdminPharmacyScreen({super.key});

  @override
  State<AdminPharmacyScreen> createState() => _AdminPharmacyScreenState();
}

class _AdminPharmacyScreenState extends State<AdminPharmacyScreen> {
  int pageIndex = 0;
  String pharmacyId = "";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return (pageIndex == 1)
        ? AdminMedicineScreen(
            onBackPressed: () {
              setState(() {
                pageIndex = 0;
                pharmacyId = "";
              });
            },
            pharmacyId: pharmacyId,
          )
        : Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pharmacy",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                  insetPadding: const EdgeInsets.all(20),
                                  child: AddPharmacyDialogWidget()));
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
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.5,
                        child: const Text(
                          "Action",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
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
                          .collection('pharmacies')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                        List<PharmacyModel> pharmacyData =
                            snapshot.data!.docs.map((doc) {
                          Map<String, dynamic> data =
                              doc.data() as Map<String, dynamic>;
                          return PharmacyModel.fromJson(data);
                        }).toList();
                        final documents = snapshot.data!.docs;
                        return SizedBox(
                          child: ListView.builder(
                            itemCount: pharmacyData.length,
                            itemBuilder: (context, index) {
                              PharmacyModel pharmacy = pharmacyData[index];
                              return Container(
                                margin:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width * 0.3,
                                      child: Text(
                                        pharmacy.name,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                        width: width * 0.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        Dialog(
                                                            insetPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child:
                                                                EditPharmacyDialogWidget(
                                                              docId: documents[
                                                                      index]
                                                                  .id,
                                                              name:
                                                                  pharmacy.name,
                                                              address: pharmacy
                                                                  .address,
                                                            )));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.green
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        Dialog(
                                                            insetPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child:
                                                                ConfirmationDialogWidget(
                                                              message:
                                                                  'Are you sure, you want to delete this Pharmacy? All Medicine present in this pharmacy will also be deleted',
                                                              onCancelFunction:
                                                                  () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              onConfirmFunction:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context);
                                                                await appConstants
                                                                    .pharmacyServices
                                                                    .delete(
                                                                        docId: documents[index]
                                                                            .id,
                                                                        context:
                                                                            context);
                                                              },
                                                              title:
                                                                  "Delete Medicine",
                                                            )));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.red
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  pageIndex = 1;
                                                  pharmacyId =
                                                      documents[index].id;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.blueAccent
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: const Text(
                                                  "Medicine",
                                                  style: TextStyle(
                                                      color: Colors.blueAccent,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
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
