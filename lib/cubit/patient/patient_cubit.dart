import 'package:bloc/bloc.dart';
import 'package:doctor_patient_management_system/Models/PatientModel.dart';
import 'package:meta/meta.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientCubit()
      : super(PatientState(
            patientModel: PatientModel(
          phoneNumber: "",
          address: "",
          cnic: "",
          gender: "",
        )));

  updatePatientModel({required PatientModel singlePatientModel}) {
    emit(PatientState(patientModel: singlePatientModel));
  }
}
