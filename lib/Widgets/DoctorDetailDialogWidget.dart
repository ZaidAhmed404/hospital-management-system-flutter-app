import 'package:flutter/material.dart';

import '../Models/DoctorModel.dart';
import '../main.dart';

class DoctorDetailDialogWidget extends StatelessWidget {
  DoctorDetailDialogWidget({super.key, required this.doctorModel});

  DoctorModel doctorModel;

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
                  doctorModel.name,
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
                  doctorModel.address,
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
                  doctorModel.cnic,
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
                  doctorModel.gender,
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
                  doctorModel.phoneNumber,
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
                  doctorModel.licenseNumber,
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
                  doctorModel.specialization,
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
                  "Rs.${doctorModel.hourlyRate}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
