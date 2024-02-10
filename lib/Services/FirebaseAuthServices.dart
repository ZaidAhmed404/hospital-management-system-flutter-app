import 'dart:developer';

import 'package:doctor_patient_management_system/cubit/loading/loading_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  userLogin(
      {required BuildContext context,
      required String emailAddress,
      required String password}) async {
    BlocProvider.of<LoadingCubit>(context).setLoading(true);

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      messageWidget(
          context: context,
          isError: false,
          message: "User Signed in successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
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
