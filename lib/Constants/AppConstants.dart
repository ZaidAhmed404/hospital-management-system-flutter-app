import 'package:doctor_patient_management_system/Services/CommonServices.dart';
import 'package:doctor_patient_management_system/Services/DoctorServices.dart';
import 'package:doctor_patient_management_system/Services/FirebaseAuthServices.dart';
import 'package:doctor_patient_management_system/Services/MedicineServices.dart';
import 'package:doctor_patient_management_system/Services/PatientServices.dart';
import 'package:doctor_patient_management_system/cubit/DoctorCubit/doctor_cubit.dart';

class AppConstants {
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
  DoctorServices doctorServices = DoctorServices();
  PatientServices patientServices = PatientServices();
  CommonServices commonServices = CommonServices();
  MedicineServices medicineServices = MedicineServices();
  String role = "";
  String shareMessage =
      "Hope you're doing well! I recently discovered this amazing doctor and patient app that's a game-changer. It's super convenient for managing health, scheduling appointments, and getting quick consultations. I thought you might find it useful too. How about we check it out together? It could be a fun way to prioritize our health. ";
}
