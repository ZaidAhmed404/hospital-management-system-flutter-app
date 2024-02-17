import 'dart:developer';
import 'dart:io';

import 'package:doctor_patient_management_system/Models/DoctorModel.dart';
import 'package:doctor_patient_management_system/cubit/DoctorCubit/doctor_cubit.dart';
import 'package:doctor_patient_management_system/cubit/LoadingCubit/loading_cubit.dart';
import 'package:doctor_patient_management_system/cubit/UserCubit/user_cubit.dart';

import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Route/CustomPageRoute.dart';
import '../Widgets/MessageWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void signUp(
      {required BuildContext context,
      required String email,
      required String password}) async {
    BlocProvider.of<LoadingCubit>(context).setLoading(true);
    FocusScope.of(context).unfocus();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("$userCredential", name: "user credentials");
      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message: "User Signed up successfully");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: e.message.toString());
      }
    } catch (e) {
      log(e.toString());
      if (context.mounted) {
        messageWidget(context: context, isError: true, message: e.toString());
      }
    }
    if (context.mounted) {
      BlocProvider.of<LoadingCubit>(context).setLoading(false);
    }
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
    FocusScope.of(context).unfocus();

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message: "User Signed in successfully");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: e.message.toString());
      }
    } catch (e) {
      log(e.toString());
      if (context.mounted) {
        messageWidget(context: context, isError: true, message: e.toString());
      }
    }
    if (context.mounted) {
      BlocProvider.of<LoadingCubit>(context).setLoading(false);
    }
  }

  User? getUser({required BuildContext context}) {
    BlocProvider.of<LoadingCubit>(context).setLoading(true);

    User? _user = FirebaseAuth.instance.currentUser;
    BlocProvider.of<LoadingCubit>(context).setLoading(false);

    return _user;
  }

  Future sendEmail(
      {required BuildContext context, required String email}) async {
    BlocProvider.of<LoadingCubit>(context).setLoading(true);
    FocusScope.of(context).unfocus();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (context.mounted) {
        messageWidget(
            context: context,
            isError: false,
            message:
                "A password reset email has been sent to your inbox. Please check and follow the instructions. If not in your inbox, look in your spam folder.");
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: "Something went wrong");
      }
      log("$error", name: "error sending email");
    }
    if (context.mounted) {
      BlocProvider.of<LoadingCubit>(context).setLoading(false);
    }
  }

  Future registerUserRole(
      {required BuildContext context,
      required String photoPath,
      required String displayName,
      required String cnic,
      required String address,
      required String phoneNumber,
      required String role,
      required String gender,
      required String doctorLicense,
      required String doctorSpecialization,
      required User user}) async {
    BlocProvider.of<LoadingCubit>(context).setLoading(true);
    FocusScope.of(context).unfocus();
    try {
      final file = File(photoPath);
      final metadata = SettableMetadata(contentType: "image/jpeg");

      final storageRef = FirebaseStorage.instance.ref();
      final uploadTask = storageRef
          .child("profile images/${user.uid}")
          .putFile(file, metadata);
      final snapshot = await uploadTask.whenComplete(() => null);

      String url = await snapshot.ref.getDownloadURL();
      await user.updateDisplayName(displayName);
      await user.updatePhotoURL(url);

      if (role == "Doctor") {
        CollectionReference doctor =
            FirebaseFirestore.instance.collection('doctors');

        doctor
            .doc(user.uid)
            .set({
              'cnic': cnic,
              'address': address,
              'phoneNumber': phoneNumber,
              "gender": gender,
              "licenseNumber": doctorLicense,
              "specialization": doctorSpecialization
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      } else {
        CollectionReference patient =
            FirebaseFirestore.instance.collection('patients');

        patient
            .doc(user.uid)
            .set({
              'cnic': cnic,
              'address': address,
              'phoneNumber': phoneNumber,
              "gender": gender
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }

      if (context.mounted) {
        BlocProvider.of<UserCubit>(context).updateDisplayName(displayName);
        BlocProvider.of<UserCubit>(context).updatePhotoUrl(url);
        messageWidget(
            context: context,
            isError: false,
            message: "User Role Registered Successfully");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: e.message.toString());
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: "Something went wrong");
      }
      log("$error", name: "error registering user");
    }
    if (context.mounted) {
      BlocProvider.of<LoadingCubit>(context).setLoading(false);
    }
  }

  Future updateDoctorData(
      {required BuildContext context,
      required User? user,
      required String photoPath,
      required String name,
      required String phoneNumber,
      required String cnic,
      required String address,
      required String gender,
      required String licenseNumber,
      required String specialization}) async {
    BlocProvider.of<LoadingCubit>(context).setLoading(true);
    FocusScope.of(context).unfocus();
    try {
      if (photoPath != "") {
        final file = File(photoPath);
        final metadata = SettableMetadata(contentType: "image/jpeg");

        final storageRef = FirebaseStorage.instance.ref();
        final uploadTask = storageRef
            .child("profile images/${user?.uid}")
            .putFile(file, metadata);
        final snapshot = await uploadTask.whenComplete(() => null);

        String url = await snapshot.ref.getDownloadURL();
        await user?.updatePhotoURL(url);
        if (context.mounted) {
          BlocProvider.of<UserCubit>(context).updatePhotoUrl(url);
        }
      }
      await user?.updateDisplayName(name);
      if (context.mounted) {
        BlocProvider.of<UserCubit>(context).updateDisplayName(name);
      }
      CollectionReference doctor =
          FirebaseFirestore.instance.collection('doctors');

      doctor
          .doc(user?.uid)
          .update({
            'cnic': cnic,
            'address': address,
            'phoneNumber': phoneNumber,
            "licenseNumber": licenseNumber,
            "specialization": specialization
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      BlocProvider.of<DoctorCubit>(context).updateDoctorModel(
          singleDoctorModel: DoctorModel(
              address: address,
              cnic: cnic,
              phoneNumber: phoneNumber,
              gender: gender,
              licenseNumber: licenseNumber,
              specialization: specialization));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: e.message.toString());
      }
    } catch (error) {
      if (context.mounted) {
        messageWidget(
            context: context, isError: true, message: "Something went wrong");
      }
      log("$error", name: "error updating user");
    }
    if (context.mounted) {
      messageWidget(
          context: context,
          isError: false,
          message: "Profile Updated Successfully");
    }
    if (context.mounted) {
      BlocProvider.of<LoadingCubit>(context).setLoading(false);
    }
  }
}
