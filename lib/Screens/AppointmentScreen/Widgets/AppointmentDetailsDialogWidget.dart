import 'package:doctor_patient_management_system/Models/AppointmentModel.dart';
import 'package:flutter/material.dart';

import '../../../Models/DoctorModel.dart';
import '../../../main.dart';

class AppointmentDetailsDialogWidget extends StatelessWidget {
  AppointmentDetailsDialogWidget({super.key, required this.appointmentModel});

  AppointmentModel appointmentModel;

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
              "Appointment Details",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Problem Name",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.name,
              style: TextStyle(
                fontSize: height * appConstants.fontSize14,
              ),
            ),
            const Divider(),
            Text(
              "Problem Description",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.description,
              style: TextStyle(
                fontSize: height * appConstants.fontSize14,
              ),
            ),
            const Divider(),
            Text(
              "Doctor Name",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.doctorName,
              style: TextStyle(
                fontSize: height * appConstants.fontSize14,
              ),
            ),
            const Divider(),
            Text(
              "Patient Name",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.patientName,
              style: TextStyle(fontSize: height * appConstants.fontSize14),
            ),
            const Divider(),
            Text(
              "Appointment Date",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.appointmentDate,
              style: TextStyle(
                fontSize: height * appConstants.fontSize14,
              ),
            ),
            const Divider(),
            Text(
              "Starting Time",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.startTime,
              style: TextStyle(
                fontSize: height * appConstants.fontSize14,
              ),
            ),
            const Divider(),
            Text(
              "Ending Time",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.endTime,
              style: TextStyle(
                fontSize: height * appConstants.fontSize14,
              ),
            ),
            const Divider(),
            Text(
              "Time Slot",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.timeSlot,
              style: TextStyle(
                fontSize: height * appConstants.fontSize14,
              ),
            ),
            const Divider(),
            Text(
              "Appointment Type",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.appointmentType,
              style: TextStyle(
                fontSize: height * appConstants.fontSize14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
