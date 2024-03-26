import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Models/OrderMedicines.dart';
import '../../main.dart';
import '../PatientMedicinesScreen/Widgets/OrdeDetailsDialogWidget.dart';
import 'Widgets/ChangeOrderStatusDialogWidget.dart';

class PharmacyOwnerOrderScreen extends StatelessWidget {
  const PharmacyOwnerOrderScreen({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Orders",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: height * appConstants.fontSize20),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.75,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('orderMedicines')
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
                    List<OrderMedicineModel> orderMedicines = snapshot
                        .data!.docs
                        .map((doc) {
                          Map<String, dynamic> data =
                              doc.data() as Map<String, dynamic>;
                          return OrderMedicineModel.fromMap(data);
                        })
                        .where((order) => (order.ownerId ==
                            FirebaseAuth.instance.currentUser!.uid))
                        .toList();
                    final documents = snapshot.data!.docs;
                    return SizedBox(
                      child: ListView.builder(
                        itemCount: orderMedicines.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderMedicines[index].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            height * appConstants.fontSize15),
                                  ),
                                  Text(
                                    orderMedicines[index].status,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            height * appConstants.fontSize15),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Dialog(
                                                insetPadding:
                                                    const EdgeInsets.all(20),
                                                child: OrderDetailsDialogWidget(
                                                  orderMedicineModel:
                                                      orderMedicines[index],
                                                )));
                                  },
                                  child: const Text("Details")),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              Dialog(
                                                  insetPadding:
                                                      const EdgeInsets.all(20),
                                                  child:
                                                      ChangeOrderStatusDialogWidget(
                                                    docId: documents[index].id,
                                                  )));
                                    },
                                    child: const Text(
                                      "Change Status",
                                      style: TextStyle(color: Colors.green),
                                    )),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
