import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/DoctorModel.dart';
import '../Models/RateModel.dart';
import '../main.dart';

class DoctorDetailDialogWidget extends StatefulWidget {
  DoctorDetailDialogWidget({super.key, required this.doctorModel});

  DoctorModel doctorModel;

  @override
  State<DoctorDetailDialogWidget> createState() =>
      _DoctorDetailDialogWidgetState();
}

class _DoctorDetailDialogWidgetState extends State<DoctorDetailDialogWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRating();
  }

  bool isLoading = false;
  List<RateModel> rating = [];

  Future getRating() async {
    setState(() {
      isLoading = true;
    });
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('rateDoctors').get();

      for (var document in snapshot.docs) {
        if (document.exists) {
          RateModel rate = RateModel.fromJson(document.data()!);
          if (rate.doctorId == widget.doctorModel.userId) {
            rating.add(rate);
          }
        }
      }
    } catch (e) {
      log("Error retrieving RateModels from Firestore: $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Doctor Details",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name",
                  style: TextStyle(
                      fontSize: height * appConstants.fontSize14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.doctorModel.name,
                  style: TextStyle(
                    fontSize: height * appConstants.fontSize14,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Address",
                  style: TextStyle(
                      fontSize: height * appConstants.fontSize14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.doctorModel.address,
                  style: TextStyle(
                    fontSize: height * appConstants.fontSize14,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CNIC",
                  style: TextStyle(
                      fontSize: height * appConstants.fontSize14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.doctorModel.cnic,
                  style: TextStyle(
                    fontSize: height * appConstants.fontSize14,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Gender",
                  style: TextStyle(
                      fontSize: height * appConstants.fontSize14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.doctorModel.gender,
                  style: TextStyle(
                    fontSize: height * appConstants.fontSize14,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone Number",
                  style: TextStyle(
                      fontSize: height * appConstants.fontSize14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.doctorModel.phoneNumber,
                  style: TextStyle(
                    fontSize: height * appConstants.fontSize14,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "License Number",
                  style: TextStyle(
                      fontSize: height * appConstants.fontSize14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.doctorModel.licenseNumber,
                  style: TextStyle(
                    fontSize: height * appConstants.fontSize14,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Specialization",
                  style: TextStyle(
                      fontSize: height * appConstants.fontSize14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.doctorModel.specialization,
                  style: TextStyle(
                    fontSize: height * appConstants.fontSize14,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Hourly Rate",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Rs.${widget.doctorModel.hourlyRate}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Divider(),
            if (isLoading)
              const Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              )),
            if (isLoading == false)
              Text(
                "User Ratings",
                style: TextStyle(
                    fontSize: height * appConstants.fontSize14,
                    fontWeight: FontWeight.w600),
              ),
            if (isLoading == false)
              const SizedBox(
                height: 20,
              ),
            if (isLoading == false && rating.isEmpty)
              Center(
                child: Text(
                  "No Ratings",
                  style: TextStyle(
                      fontSize: height * appConstants.fontSize14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            if (isLoading == false && rating.isNotEmpty)
              for (int index = 0; index < rating.length; index++)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          rating[index].senderName,
                          style: TextStyle(
                              fontSize: height * appConstants.fontSize14,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${rating[index].rate} / 5.0",
                          style: TextStyle(
                              fontSize: height * appConstants.fontSize14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Text(
                      rating[index].description,
                      style: TextStyle(
                          fontSize: height * appConstants.fontSize14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
          ],
        ),
      ),
    );
  }
}
