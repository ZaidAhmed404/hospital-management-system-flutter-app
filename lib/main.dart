import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_patient_management_system/Constants/AppConstants.dart';
import 'package:doctor_patient_management_system/cubit/DoctorCubit/doctor_cubit.dart';
import 'package:doctor_patient_management_system/cubit/UserCubit/user_cubit.dart';
import 'package:doctor_patient_management_system/cubit/patient/patient_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'Models/DoctorModel.dart';
import 'cubit/LoadingCubit/loading_cubit.dart';
import 'firebase_options.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

AppConstants appConstants = AppConstants();
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey =
      "pk_test_51OutwwP5SW1IvPMLZRGaeqVwBJ5LB9UeDUtTdPvZq86MU3tiRAg4KixmuMCMd62fSIMAVKuOzTwmDBM1SFHK3OAe00JLCyHAT7";
  Stripe.merchantIdentifier =
      'pk_test_51OutwwP5SW1IvPMLZRGaeqVwBJ5LB9UeDUtTdPvZq86MU3tiRAg4KixmuMCMd62fSIMAVKuOzTwmDBM1SFHK3OAe00JLCyHAT7';
  await Stripe.instance.applySettings();

  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  /// call the useSystemCallingUI
  await ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp(navigatorKey: navigatorKey));
  });
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoadingCubit(),
          ),
          BlocProvider(
            create: (context) => UserCubit(),
          ),
          BlocProvider(
            create: (context) => DoctorCubit(),
          ),
          BlocProvider(
            create: (context) => PatientCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Hospital Management System',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
          navigatorKey: navigatorKey,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: [
                child!,

                /// support minimizing
                ZegoUIKitPrebuiltCallMiniOverlayPage(
                  contextQuery: () {
                    return navigatorKey.currentState!.context;
                  },
                ),
              ],
            );
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appConstants.commonServices.initializeSetting(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/images/logo.png"),
            const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
