import 'dart:developer';

import 'package:doctor_patient_management_system/cubit/loading/loading_cubit.dart';

import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Route/CustomPageRoute.dart';
import '../Screens/OtpScreen/OtpScreen.dart';
import '../Screens/ResetPasswordScreen/ResetPasswordScreen.dart';
import '../Widgets/MessageWidget.dart';

class FirebaseAuthServices {
  EmailOTP myauth = EmailOTP();

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

  Future sendOtp({required BuildContext context, required String email}) async {
    BlocProvider.of<LoadingCubit>(context).setLoading(true);
    FocusScope.of(context).unfocus();
    try {
      myauth.setConfig(
          appEmail: "me@rohitchouhan.com",
          appName: "Email OTP",
          userEmail: email,
          otpLength: 4,
          otpType: OTPType.digitsOnly);
      // await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (await myauth.sendOTP() == true) {
        if (context.mounted) {
          messageWidget(
              context: context,
              isError: false,
              message:
                  "Your One-Time Password (OTP) has been sent to your email for account verification. Please check your inbox. If not in your inbox, please check spam.");
        }
        if (context.mounted) {
          Navigator.of(context).push(CustomPageRoute(child: OtpScreen()));
        }
      } else {
        if (context.mounted) {
          messageWidget(
              context: context,
              isError: true,
              message: "Oops, OTP send failed");
        }
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

  Future verifyOtp({required BuildContext context, required String otp}) async {
    BlocProvider.of<LoadingCubit>(context).setLoading(true);
    FocusScope.of(context).unfocus();
    try {
      if (await myauth.verifyOTP(otp: otp) == true) {
        if (context.mounted) {
          Navigator.of(context)
              .push(CustomPageRoute(child: ResetPasswordScreen()));
        }
        if (context.mounted) {
          messageWidget(
              context: context, isError: false, message: "OTP is verified");
        }
      } else {
        if (context.mounted) {
          messageWidget(
              context: context, isError: true, message: "Invalid OTP");
        }
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

  Future changePassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    if (context.mounted) {
      BlocProvider.of<LoadingCubit>(context).setLoading(true);
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: 'dummypassword',
      );
      log("$userCredential", name: "");
      return true;
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (context.mounted) {
          messageWidget(context: context, isError: true, message: e.message!);
        }
      } else {
        log("Error checking user registration: $e");
        if (context.mounted) {
          messageWidget(
              context: context,
              isError: true,
              message: "Error checking user registration: $e");
        }
      }
    }
    if (context.mounted) {
      BlocProvider.of<LoadingCubit>(context).setLoading(false);
    }
  }
}
