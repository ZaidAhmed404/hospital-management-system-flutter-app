import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/Models/DoctorModel.dart';
import 'package:doctor_patient_management_system/cubit/LoadingCubit/loading_cubit.dart';
import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'Widgets/DoctorDetailDialogWidget.dart';

class AdminDoctorScreen extends StatelessWidget {
  const AdminDoctorScreen({super.key});

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
              child: const CircularProgressIndicator()),
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Doctors",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('doctors')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Container(
                              width: 50,
                              height: 50,
                              child: const CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        List<DoctorModel> doctorData =
                            snapshot.data!.docs.map((doc) {
                          Map<String, dynamic> data =
                              doc.data() as Map<String, dynamic>;
                          return DoctorModel.fromMap(data);
                        }).toList();

                        final documents = snapshot.data!.docs;
                        return SizedBox(
                          child: ListView.builder(
                            itemCount: doctorData.length,
                            itemBuilder: (context, index) {
                              DoctorModel doctor = doctorData[index];
                              return Container(
                                margin:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                        DoctorDetailDialogWidget(
                                                      doctorModel: doctor,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          ClipOval(
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(20),
                                              child: Image.network(
                                                doctor.photoUrl,
                                                frameBuilder: (context, child,
                                                    frame, was) {
                                                  return child;
                                                },
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                      child: SizedBox(
                                                          width: 70,
                                                          height: 70,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child:
                                                                const CircularProgressIndicator(
                                                              color: Color(
                                                                  0xff3FA8F9),
                                                            ),
                                                          )));
                                                },
                                                fit: BoxFit.fill,
                                                width: width * 0.75,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            doctor.name,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      child: const Text(
                                        "Approve",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      onPressed: () async {
                                        appConstants.doctorServices
                                            .updateProfileStatus(
                                                docId: documents[index].id,
                                                context: context,
                                                status: "approved");
                                      },
                                    )
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
          ),
        );
      },
    );
  }
}
