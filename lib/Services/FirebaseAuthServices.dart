import 'dart:developer';

import 'package:doctor_patient_management_system/cubit/loading/loading_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/MessageWidget.dart';

class FirebaseAuthServices {
  void signUp(
      {required BuildContext context,
      required String email,
      required String password}) async {
    BlocProvider.of<LoadingCubit>(context).setLoading(true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      messageWidget(
          context: context,
          isError: false,
          message: "User Signed up successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      messageWidget(
          context: context, isError: true, message: e.message.toString());
    } catch (e) {
      log(e.toString());
      messageWidget(context: context, isError: true, message: e.toString());
    }

    BlocProvider.of<LoadingCubit>(context).setLoading(false);
  }

  User? getUser({required BuildContext context}) {
    BlocProvider.of<LoadingCubit>(context).setLoading(true);

    User? _user = FirebaseAuth.instance.currentUser;
    BlocProvider.of<LoadingCubit>(context).setLoading(false);

    return _user;
  }
}
