import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/cubit/UserCubit/user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/DoctorModel.dart';
import '../../Widgets/ButtonWidget.dart';
import '../../Widgets/CategoryWidget.dart';
import '../../Widgets/DoctorDetailDialogWidget.dart';
import '../../Widgets/DropdownWidget.dart';
import '../../Widgets/TextFieldWidget.dart';
import '../../main.dart';
import '../AppointmentScreen/AppointmentScreen.dart';

class SearchDoctorScreen extends StatefulWidget {
  SearchDoctorScreen(
      {super.key, required this.onBackPressed, required this.onBookPressed});

  Function(int) onBackPressed;
  Function(int, String, String, String) onBookPressed;

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

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return index == 1
        ? AppointmentScreen(
            onPressedFunction: () => widget.onBackPressed(0),
          )
        : BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return Container(
                width: width,
                height: height,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${FirebaseAuth.instance.currentUser!.displayName}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: height * appConstants.fontSize20),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => imageDialog('My Image',
                                      state.userModel.photoUrl, context));
                            },
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(20),
                                child: Image.network(
                                  state.userModel.photoUrl,
                                  frameBuilder: (context, child, frame, was) {
                                    return child;
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                        child: SizedBox(
                                            width: 70,
                                            height: 70,
                                            child: Container(
                                              padding: const EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child:
                                                  const CircularProgressIndicator(
                                                color: Color(0xff3FA8F9),
                                              ),
                                            )));
                                  },
                                  fit: BoxFit.fill,
                                  width: width * 0.75,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Welcome to Sehat Sakoon",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: height * appConstants.fontSize20),
                      ),
                      const SizedBox(
                        height: 10,
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
                        maxLines: 1,
                        borderCircular: 50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: height * appConstants.fontSize18,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoryWidget(
                            width: width,
                            field: "Neurologist",
                            imageLocation: "assets/images/1.jpeg",
                          ),
                          CategoryWidget(
                            width: width,
                            field: "Gynaecologist",
                            imageLocation: "assets/images/2.jpeg",
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoryWidget(
                            width: width,
                            field: "Cardiologist",
                            imageLocation: "assets/images/3.jpeg",
                          ),
                          CategoryWidget(
                            width: width,
                            field: "Orthopedic",
                            imageLocation: "assets/images/4.jpeg",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Doctors",
                        style: TextStyle(
                            fontSize: height * appConstants.fontSize18,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('doctors')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
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

                              if (searchController.text.isNotEmpty) {
                                if (filter == "Name") {
                                  doctorData = snapshot.data!.docs
                                      .map((doc) {
                                        Map<String, dynamic> data =
                                            doc.data() as Map<String, dynamic>;
                                        return DoctorModel.fromMap(data);
                                      })
                                      .where((doctor) => doctor.name.contains(
                                          searchController.text.trim()))
                                      .toList();
                                } else if (filter == "Specialization") {
                                  doctorData = snapshot.data!.docs
                                      .map((doc) {
                                        Map<String, dynamic> data =
                                            doc.data() as Map<String, dynamic>;
                                        return DoctorModel.fromMap(data);
                                      })
                                      .where((doctor) => doctor.specialization
                                          .contains(
                                              searchController.text.trim()))
                                      .toList();
                                }
                              } else {
                                doctorData = snapshot.data!.docs.map((doc) {
                                  Map<String, dynamic> data =
                                      doc.data() as Map<String, dynamic>;
                                  return DoctorModel.fromMap(data);
                                }).toList();
                              }

                              // final documents = snapshot.data!.docs;
                              return SizedBox(
                                child: doctorData.isEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/pending.png",
                                            width: 200,
                                            height: 200,
                                          ),
                                          Text(
                                            "No Doctors Found",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: height *
                                                    appConstants.fontSize18),
                                          ),
                                        ],
                                      )
                                    : ListView.builder(
                                        itemCount: doctorData.length,
                                        itemBuilder: (context, index) {
                                          DoctorModel doctor =
                                              doctorData[index];
                                          return Container(
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ]),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                                        .all(
                                                                        20),
                                                                child:
                                                                    DoctorDetailDialogWidget(
                                                                  doctorModel:
                                                                      doctor,
                                                                )));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      ClipOval(
                                                        child:
                                                            SizedBox.fromSize(
                                                          size: const Size
                                                              .fromRadius(20),
                                                          child: Image.network(
                                                            doctor.photoUrl,
                                                            frameBuilder:
                                                                (context,
                                                                    child,
                                                                    frame,
                                                                    was) {
                                                              return child;
                                                            },
                                                            loadingBuilder:
                                                                (context, child,
                                                                    loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null) {
                                                                return child;
                                                              }
                                                              return Center(
                                                                  child: SizedBox(
                                                                      width: 70,
                                                                      height: 70,
                                                                      child: Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            20),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            const CircularProgressIndicator(
                                                                          color:
                                                                              Color(0xff3FA8F9),
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            doctor.name,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: height *
                                                                    appConstants
                                                                        .fontSize14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            doctor
                                                                .specialization,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: height *
                                                                    appConstants
                                                                        .fontSize14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ElevatedButton(
                                                    // onPressed: () {
                                                    //
                                                    //   doctorId = doctor.userId;
                                                    //   setState(() {
                                                    //     index = 2;
                                                    //   });
                                                    // },
                                                    onPressed: () =>
                                                        widget.onBookPressed(
                                                            2,
                                                            doctor.userId,
                                                            doctor.name,
                                                            doctor.photoUrl),
                                                    child: Text(
                                                      "Book",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: height *
                                                              appConstants
                                                                  .fontSize14),
                                                    ))
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                              );
                            },
                          )),
                      ButtonWidget(
                          onPressedFunction: () {
                            setState(() {
                              index = 1;
                            });
                          },
                          buttonText: "Appointments History",
                          buttonColor: Colors.blue,
                          borderColor: Colors.blue,
                          textColor: Colors.white,
                          buttonWidth: MediaQuery.of(context).size.width),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}

Widget imageDialog(text, path, context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$text',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close_rounded),
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
        Image.network(
          '$path',
          fit: BoxFit.cover,
        ),
      ],
    ),
  );
}
