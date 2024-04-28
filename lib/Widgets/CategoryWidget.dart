import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/DoctorModel.dart';
import '../main.dart';
import 'DoctorDetailDialogWidget.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget(
      {super.key,
      required this.width,
      required this.field,
      required this.imageLocation});

  double width;
  String field;
  String imageLocation;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
                height: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('doctors')
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
                    List<DoctorModel> doctorData = snapshot.data!.docs
                        .map((doc) {
                          Map<String, dynamic> data =
                              doc.data() as Map<String, dynamic>;
                          return DoctorModel.fromMap(data);
                        })
                        .where(
                            (element) => element.specialization == widget.field)
                        .toList();
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
                                Text(
                                  "No Doctors Found",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          height * appConstants.fontSize18),
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: doctorData.length,
                              itemBuilder: (context, index) {
                                DoctorModel doctor = doctorData[index];
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
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
                                                  width: widget.width * 0.75,
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
                                                  style: TextStyle(
                                                      fontSize: height *
                                                          appConstants
                                                              .fontSize14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  doctor.specialization,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: height *
                                                          appConstants
                                                              .fontSize14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    );
                  },
                ));
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        width: widget.width * 0.4,
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(widget.imageLocation),
            ),
            Text(
              widget.field,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
