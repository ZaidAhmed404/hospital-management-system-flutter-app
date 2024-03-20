import 'package:doctor_patient_management_system/Models/AppointmentModel.dart';
import 'package:flutter/material.dart';

import '../../../Models/DoctorModel.dart';

class AppointmentDetailsDialogWidget extends StatelessWidget {
  AppointmentDetailsDialogWidget({super.key, required this.appointmentModel});

  AppointmentModel appointmentModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Appointment Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Problem Name",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.name,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const Divider(),
            const Text(
              "Problem Description",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.description,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const Divider(),
            const Text(
              "Doctor Name",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.doctorName,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const Divider(),
            const Text(
              "Patient Name",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.patientName,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const Divider(),
            const Text(
              "Appointment Date",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.appointmentDate,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const Divider(),
            const Text(
              "Starting Time",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.startTime,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const Divider(),
            const Text(
              "Ending Time",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.endTime,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const Divider(),
            const Text(
              "Time Slot",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.timeSlot,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const Divider(),
            const Text(
              "Appointment Type",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              appointmentModel.appointmentType,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
