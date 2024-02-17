import 'package:bloc/bloc.dart';
import 'package:doctor_patient_management_system/Models/UserModel.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit()
      : super(UserState(
            userModel:
                UserModel(displayName: "", email: "", photoUrl: "", uid: "")));

  updateUserModel({
    required String email,
    required String uid,
    required String displayName,
    required String photoUrl,
  }) {
    emit(UserState(
        userModel: UserModel(
            displayName: displayName,
            email: email,
            photoUrl: photoUrl,
            uid: uid)));
  }

  updateEmail(String email) {
    emit(UserState(
        userModel: UserModel(
      displayName: state.userModel.displayName,
      email: email,
      photoUrl: state.userModel.photoUrl,
      uid: state.userModel.uid,
    )));
  }

  updateDisplayName(String displayName) {
    emit(UserState(
        userModel: UserModel(
      displayName: displayName,
      email: state.userModel.email,
      photoUrl: state.userModel.photoUrl,
      uid: state.userModel.uid,
    )));
  }

  updatePhotoUrl(String photoUrl) {
    emit(UserState(
        userModel: UserModel(
      displayName: state.userModel.displayName,
      email: state.userModel.email,
      photoUrl: photoUrl,
      uid: state.userModel.uid,
    )));
  }
}
