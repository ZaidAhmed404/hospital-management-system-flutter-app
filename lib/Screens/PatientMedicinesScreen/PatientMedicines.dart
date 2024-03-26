import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/cubit/LoadingCubit/loading_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../Models/OrderMedicines.dart';
import '../../main.dart';
import 'Widgets/OrdeDetailsDialogWidget.dart';
import 'Widgets/OrderMedicineDialogWidget.dart';

class PatientMedicinesScreen extends StatelessWidget {
  PatientMedicinesScreen({super.key, required this.onBackPressed});

  Function(int) onBackPressed;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<LoadingCubit, LoadingState>(
      builder: (context, state) {
        return LoadingOverlay(
          isLoading: state.loading,
          color: Colors.black,
          opacity: 0.5,
          progressIndicator: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const CircularProgressIndicator(
                color: Colors.blue,
              )),
          child: Container(
              width: width,
              height: height,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => onBackPressed(0),
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue.withOpacity(0.2)),
                              child: const Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.blue,
                              )),
                        ),
                        const Spacer(),
                        Text(
                          "Order Medicines",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: height * appConstants.fontSize20),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => const Dialog(
                                    insetPadding: EdgeInsets.all(20),
                                    child: OrderMedicineDialogWidget()));
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
                        ),
                      ],
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
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                              .where((order) => (order.userId ==
                                  FirebaseAuth.instance.currentUser!.uid))
                              .toList();
                          final documents = snapshot.data!.docs;
                          return SizedBox(
                            child: ListView.builder(
                              itemCount: orderMedicines.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          orderMedicines[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: height *
                                                  appConstants.fontSize15),
                                        ),
                                        Text(
                                          orderMedicines[index].status,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: height *
                                                  appConstants.fontSize15),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  Dialog(
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      child:
                                                          OrderDetailsDialogWidget(
                                                        orderMedicineModel:
                                                            orderMedicines[
                                                                index],
                                                      )));
                                        },
                                        child: const Text("Details"))
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
              )),
        );
      },
    );
  }
}
