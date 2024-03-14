import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Models/DoctorModel.dart';
import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/DropdownWidget.dart';
import '../../Widgets/TextFieldWidget.dart';

class SearchDoctorScreen extends StatefulWidget {
  SearchDoctorScreen({super.key, required this.onBackPressed});

  Function(int) onBackPressed;

  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

const List<String> filters = <String>[
  'Name',
  "Specialization",
];

class _SearchDoctorScreenState extends State<SearchDoctorScreen> {
  final TextEditingController searchController = TextEditingController();
  List<DoctorModel> doctorData = [];
  String filter = filters.first;
  String searchValue = "";

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
              children: [
                InkWell(
                  onTap: () => widget.onBackPressed(0),
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
                const Text(
                  "Search Doctors",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            DropdownWidget(
                selectedValue: filter,
                list: filters,
                title: "Filters",
                onPressedFunction: (value) {
                  setState(() {
                    filter = value;
                  });
                }),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              hintText: "Search",
              text: "Search",
              controller: searchController,
              isPassword: false,
              isEnabled: true,
              validationFunction: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some thing';
                }
                return null;
              },
              textInputType: TextInputType.text,
              textFieldWidth: width,
              haveText: false,
              onValueChange: (value) {
                setState(() {});
              },
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('doctors')
                      .snapshots(),
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

                    if (searchController.text.isNotEmpty) {
                      if (filter == "Name") {
                        doctorData = snapshot.data!.docs
                            .map((doc) {
                              Map<String, dynamic> data =
                                  doc.data() as Map<String, dynamic>;
                              return DoctorModel.fromMap(data);
                            })
                            .where((doctor) => doctor.name
                                .contains(searchController.text.trim()))
                            .toList();
                      } else if (filter == "Specialization") {
                        doctorData = snapshot.data!.docs
                            .map((doc) {
                              Map<String, dynamic> data =
                                  doc.data() as Map<String, dynamic>;
                              return DoctorModel.fromMap(data);
                            })
                            .where((doctor) => doctor.specialization
                                .contains(searchController.text.trim()))
                            .toList();
                      }
                    } else {
                      doctorData = [];
                    }

                    // final documents = snapshot.data!.docs;
                    return SizedBox(
                      child: doctorData.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/pending.png",
                                  width: 200,
                                  height: 200,
                                ),
                                const Text(
                                  "No Doctors Found",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: doctorData.length,
                              itemBuilder: (context, index) {
                                DoctorModel doctor = doctorData[index];
                                return Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  padding: const EdgeInsets.all(20),
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
                                        onTap: () {},
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
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  doctor.name,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  doctor.specialization,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Book",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          ))
                                    ],
                                  ),
                                );
                              },
                            ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
