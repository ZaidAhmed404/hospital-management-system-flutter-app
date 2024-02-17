import 'package:bloc/bloc.dart';
import 'package:doctor_patient_management_system/Models/DoctorModel.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit()
      : super(DoctorState(
            doctorModel: DoctorModel(
                phoneNumber: "",
                address: "",
                cnic: "",
                gender: "",
                licenseNumber: '',
                specialization: '')));

  updateDoctorModel({required DoctorModel singleDoctorModel}) {
    emit(DoctorState(doctorModel: singleDoctorModel));
  }
}
