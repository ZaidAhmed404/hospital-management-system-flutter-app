import 'package:bloc/bloc.dart';
import 'package:doctor_patient_management_system/Models/UserModel.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit()
      : super(UserState(
            userModel: UserModel(
                displayName: "",
                email: "",
                phoneNumber: "",
                photoUrl: "",
                uid: "")));

  updateUserMode(
      {required String email,
      required String uid,
      required String displayName,
      required String photoUrl,
      required String phoneNumber}) {
    emit(UserState(
        userModel: UserModel(
            displayName: displayName,
            email: email,
            phoneNumber: phoneNumber,
            photoUrl: photoUrl,
            uid: uid)));
  }
}
