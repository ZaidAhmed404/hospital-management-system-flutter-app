import 'package:doctor_patient_management_system/Services/AppointmentServices.dart';
import 'package:doctor_patient_management_system/Services/ChatServices.dart';
import 'package:doctor_patient_management_system/Services/CommonServices.dart';
import 'package:doctor_patient_management_system/Services/DoctorServices.dart';
import 'package:doctor_patient_management_system/Services/FirebaseAuthServices.dart';
import 'package:doctor_patient_management_system/Services/MedicineServices.dart';
import 'package:doctor_patient_management_system/Services/PatientServices.dart';
import 'package:doctor_patient_management_system/Services/PharmacyServices.dart';

import '../Services/CallServices.dart';
import '../Services/PaymentServices.dart';

class AppConstants {
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
  DoctorServices doctorServices = DoctorServices();
  PatientServices patientServices = PatientServices();
  CommonServices commonServices = CommonServices();
  MedicineServices medicineServices = MedicineServices();
  AppointmentServices appointmentServices = AppointmentServices();
  PaymentServices paymentServices = PaymentServices();
  PharmacyServices pharmacyServices = PharmacyServices();
  CallServices callServices = CallServices();
  ChatServices chatServices = ChatServices();
  String role = "";
  String shareMessage =
      "Hope you're doing well! I recently discovered this amazing doctor and patient app that's a game-changer. It's super convenient for managing health, scheduling appointments, and getting quick consultations. I thought you might find it useful too. How about we check it out together? It could be a fun way to prioritize our health. ";
  String KommunicateAppId = "17ff5ef8b9001de0a5e1938354e018c81";
  String KommunicateApiKey = "Ju2ppmUOyYTxJ01TnUq6hhft4UNLWHer";
  final stripePublishableKey =
      "pk_test_51P7AaADutM4FFoVzXOF0zknGBTiYhc7oowj9H6njatwXXHWpFu75ywccXYNwJ4LRsZqXRmRaqX9EVgIxuUzWcCGn00V38MGXTT";

  Map categories = {
    "Orthopedic": "assets/images/4.jpeg",
    "Cardiologist": "assets/images/3.jpeg",
    "Gynaecologist": "assets/images/2.jpeg",
    "Neurologist": "assets/images/1.jpeg",
  };

  double fontSize2 = (2 / 896); //2px
  double fontSize06 = (6 / 896); //6px
  double fontSize07 = (7 / 896); //7px
  double fontSize08 = (8 / 896); //8px
  double fontSize09 = (9 / 896); //9px
  double fontSize10 = (10 / 896); //10px
  double fontSize11 = (11 / 896); //11px
  double fontSize12 = (12 / 896); //12px
  double fontSize13 = (13 / 896); //13px
  double fontSize14 = (14 / 896); //14PX
  double fontSize15 = (15 / 896); //15px
  double fontSize16 = (16 / 896); //16px
  double fontSize17 = (17 / 896); //17PX
  double fontSize18 = (18 / 896); //18px
  double fontSize19 = (19 / 896); //19px
  double fontSize20 = (20 / 896); //20px
  double fontSize21 = (21 / 896); //21px
  double fontSize22 = (22 / 896); //22px
  double fontSize23 = (23 / 896); //23px
  double fontSize24 = (24 / 896); //23px
  double fontSize25 = (25 / 896); //25px
  double fontSize26 = (26 / 896); //26px
  double fontSize27 = (27 / 896); //27px
  double fontSize28 = (28 / 896); //28px
  double fontSize30 = (30 / 896); //30px
  double fontSize32 = (32 / 896); //32px
  double fontSize33 = (33 / 896); //32px
  double fontSize38 = (38 / 896); //38px
  double fontSize40 = (40 / 896); //40px
  double fontSize42 = (42 / 896); //42px
  double fontSize50 = (50 / 896); //50px
  double fontSize60 = (60 / 896); //60px
  double fontSize70 = (70 / 896); //70px
  double fontSize78 = (78 / 896); //78px
  double fontSize80 = (80 / 896); //78px
}
