import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doctor_patient_management_system/Models/DoctorModel.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit()
      : super(DoctorState(
            doctorModel: DoctorModel(
                phoneNumber: "",
                userId: "",
                address: "",
                cnic: "",
                gender: "",
                licenseNumber: '',
                specialization: '',
                photoUrl: "",
                name: "",
                cardNumber: "",
                hourlyRate: "")));

  updateDoctorModel({required DoctorModel singleDoctorModel}) {
    log("doctor updated");
    emit(DoctorState(doctorModel: singleDoctorModel));
  }
}
