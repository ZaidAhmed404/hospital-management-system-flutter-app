import 'package:doctor_patient_management_system/Services/AppointmentServices.dart';
import 'package:doctor_patient_management_system/Services/ChatServices.dart';
import 'package:doctor_patient_management_system/Services/CommonServices.dart';
import 'package:doctor_patient_management_system/Services/DoctorServices.dart';
import 'package:doctor_patient_management_system/Services/FirebaseAuthServices.dart';
import 'package:doctor_patient_management_system/Services/MedicineServices.dart';
import 'package:doctor_patient_management_system/Services/PatientServices.dart';
import 'package:doctor_patient_management_system/Services/PharmacyServices.dart';
import 'package:doctor_patient_management_system/cubit/DoctorCubit/doctor_cubit.dart';

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

  final stripePublishableKey =
      "pk_test_51OutwwP5SW1IvPMLZRGaeqVwBJ5LB9UeDUtTdPvZq86MU3tiRAg4KixmuMCMd62fSIMAVKuOzTwmDBM1SFHK3OAe00JLCyHAT7";

  // height
  double height_2 = (2 / 896); //2px
  double height_3 = (3 / 896); //3px
  double height_4 = (4 / 896); //4px
  double height_5 = (5 / 896); //5px
  double height_6 = (6 / 896); //6px
  double height_7 = (7 / 896); //7px
  double height_8 = (8 / 896); //8px
  double height_8_7 = (8.7 / 896); //8px
  double height_9 = (9 / 896); //9px
  double height_10_5 = (10.5 / 896); //10px
  double height_10 = (10 / 896); //10px
  double height_11 = (11 / 896); //11px
  double height_12 = (12 / 896); //12px
  double height_13 = (13 / 896); //13px
  double height_14 = (14 / 896); //14px
  double height_15 = (15 / 896); //15px
  double height_16 = (16 / 896); //16px
  double height_17 = (17 / 896); //17px
  double height_18 = (18 / 896); //18px
  double height_19 = (19 / 896); //19px
  double height_20 = (20 / 896); //20px
  double height_21 = (21 / 896); //21px
  double height_22 = (22 / 896); //22px
  double height_24 = (24 / 896); //24px
  double height_23 = (23 / 896); //23px
  double height_24_1 = (24.1 / 896); //24.1px
  double height_25 = (25 / 896); //25px
  double height_26 = (26 / 896); //26px
  double height_27 = (27 / 896); //27px
  double height_28 = (28 / 896); //28px
  double height_29 = (29 / 896); //29px
  double height_30 = (30 / 896); //30px
  double height_31 = (31 / 896); //31px
  double height_32 = (32 / 896); //32px
  double height_33 = (33 / 896); //33px
  double height_34 = (34 / 896); //34px
  double height_35 = (35 / 896); //35px
  double height_37 = (37 / 896); //37px
  double height_38 = (38 / 896); //38px
  double height_39 = (39 / 896); //39px
  double height_40 = (40 / 896); //40px
  double height_42 = (42 / 896); //42px
  double height_43 = (43 / 896); //43px
  double height_44 = (44 / 896); //44px
  double height_45 = (45 / 896); //45px
  double height_46 = (46 / 896); //46px
  double height_47 = (47 / 896); //47px
  double height_49 = (49 / 896); //49px
  double height_50 = (50 / 896); //50px
  double height_51 = (51 / 896); //51px
  double height_52 = (52 / 896); //52px
  double height_53 = (53 / 896); //53px
  double height_57 = (57 / 896); //57px
  double height_58 = (58 / 896); //58px
  double height_59 = (59 / 896); //59px
  double height_60 = (60 / 896); //60px
  double height_61 = (61 / 896); //61px
  double height_63 = (63 / 896); //63px
  double height_64 = (64 / 896); //64px
  double height_65 = (65 / 896); //64px
  double height_66 = (66 / 896); //64px
  double height_68 = (68 / 896); //57px
  double height_70 = (70 / 896); //70px
  double height_71 = (71 / 896); //70px
  double height_72 = (72 / 896); //72px
  double height_73 = (73 / 896); //73px
  double height_74 = (74 / 896); //74px
  double height_75 = (75 / 896); //75px
  double height_80 = (80 / 896); //80px
  double height_81 = (81 / 896); //81px
  double height_86 = (86 / 896); //86px
  double height_87 = (87 / 896); //87px
  double height_90 = (90 / 896); //93px
  double height_93 = (93 / 896); //93px
  double height_94 = (94 / 896); //94px
  double height_97 = (97 / 896); //97px
  double height_100 = (100 / 896); //100px
  double height_102 = (102 / 896); //102px
  double height_107 = (107 / 896); //107px
  double height_108 = (108 / 896); //108px
  double height_109 = (109 / 896); //109px
  double height_110 = (110 / 896); //110px
  double height_114 = (114 / 896); //114px
  double height_115 = (115 / 896); //115px
  double height_116 = (116 / 896); //116px
  double height_117 = (117 / 896); //117px
  double height_125 = (125 / 896); //125px
  double height_140 = (140 / 896); //140px
  double height_144 = (144 / 896); //144px
  double height_145 = (145 / 896); //145px
  double height_163 = (163 / 896); //163px
  double height_166 = (166 / 896); //166px
  double height_168 = (168 / 896); //168px
  double height_173 = (173 / 896); //173px
  double height_183 = (183 / 896); //183px
  double height_185 = (185 / 896); //185px
  double height_187 = (187 / 896); //187px
  double height_188 = (188 / 896); //188px
  double height_191 = (191 / 896); //191px
  double height_192 = (192 / 896); //192px
  double height_228 = (228 / 896); //228px
  double height_231_2 = (231.2 / 896); //231.2px

  // WIDTH
  double width_2 = (2 / 414); //2px
  double width_3 = (3 / 414); //3px
  double width_4 = (4 / 414); //4px
  double width_5 = (5 / 414); //5px
  double width_6 = (6 / 414); //6px
  double width_7 = (7 / 414); //7px
  double width_8 = (8 / 414); //8px
  double width_8_7 = (8.7 / 414); //8.7px
  double width_9 = (9 / 414); //9px
  double width_10_5 = (10.5 / 414); //10px
  double width_10 = (10 / 414); //10px
  double width_11 = (11 / 414); //11px
  double width_12 = (12 / 414); //12px
  double width_13 = (13 / 414); //13px
  double width_14 = (14 / 414); //14px
  double width_15 = (15 / 414); //15px
  double width_16 = (16 / 414); //16px
  double width_17 = (17 / 414); //17px
  double width_18 = (18 / 414); //18px
  double width_19 = (19 / 414); //19px
  double width_20 = (20 / 414); //20px
  double width_27 = (27 / 414); //27px
  double width_39 = (39 / 414); //39px
  double width_45 = (45 / 414); //51px
  double width_51 = (51 / 414); //51px
  double width_70 = (70 / 414); //70px
  double width_81 = (81 / 414); //81px
  double width_88 = (88 / 414); //88px
  double width_97 = (97 / 414); //97px

  // FONT SIZE IN PERCENTAGES
  double fontsize_2 = (2 / 896); //2px
  double fontsize_06 = (6 / 896); //6px
  double fontsize_07 = (7 / 896); //7px
  double fontsize_08 = (8 / 896); //8px
  double fontsize_09 = (9 / 896); //9px
  double fontsize_10 = (10 / 896); //10px
  double fontsize_11 = (11 / 896); //11px
  double fontsize_12 = (12 / 896); //12px
  double fontsize_13 = (13 / 896); //13px
  double fontsize_14 = (14 / 896); //14PX
  double fontsize_15 = (15 / 896); //15px
  double fontsize_16 = (16 / 896); //16px
  double fontsize_17 = (17 / 896); //17PX
  double fontsize_18 = (18 / 896); //18px
  double fontsize_19 = (19 / 896); //19px
  double fontsize_20 = (20 / 896); //20px
  double fontsize_21 = (21 / 896); //21px
  double fontsize_22 = (22 / 896); //22px
  double fontsize_23 = (23 / 896); //23px
  double fontsize_24 = (24 / 896); //23px
  double fontsize_25 = (25 / 896); //25px
  double fontsize_26 = (26 / 896); //26px
  double fontsize_27 = (27 / 896); //27px
  double fontsize_28 = (28 / 896); //28px
  double fontsize_30 = (30 / 896); //30px
  double fontsize_32 = (32 / 896); //32px
  double fontsize_33 = (33 / 896); //32px
  double fontsize_38 = (38 / 896); //38px
  double fontsize_40 = (40 / 896); //40px
  double fontsize_42 = (42 / 896); //42px
  double fontsize_50 = (50 / 896); //50px
  double fontsize_60 = (60 / 896); //60px
  double fontsize_70 = (70 / 896); //70px
  double fontsize_78 = (78 / 896); //78px
  double fontsize_80 = (80 / 896); //78px

  //font sizes
  double placeholderSize = (21 / 896); //21px
  double inputTextSize = (21 / 896); // 21px
  double hintTextSize = (16 / 896);
}
