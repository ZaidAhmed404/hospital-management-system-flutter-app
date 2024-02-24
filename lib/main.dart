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
import './Screens/SignUpFlow/BoardingScreen/BoardingScreen.dart';
import './Screens/SignUpFlow/SignUpScreen/SignUpScreen.dart';
import './Screens/SignUpFlow/WelcomeScreen/WelcomeScreen.dart';
import 'Models/DoctorModel.dart';
import 'Models/PatientModel.dart';
import 'Screens/Doctor/LandingScreen/LandingScreen.dart';
import 'Screens/Patient/LandingScreen/LandingScreen.dart';
import 'Screens/SignUpFlow/RegisterUserRoleScreen/RegisterUserRolesScreen.dart';
import 'cubit/LoadingCubit/loading_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

AppConstants appConstants = AppConstants();
final FirebaseAuth auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
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
  Map<String, dynamic> data = {};
  bool gotCollectionData = false;
  String role = "";
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(context: context);
  }

  Future fetchData({required BuildContext context}) async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        log("${documentSnapshot.data()}", name: "doctor data");
        if (documentSnapshot.exists) {
          data = documentSnapshot.data() as Map<String, dynamic>;
        }
      }
    });
    if (data.isNotEmpty) {
      if (context.mounted) {
        setState(() {
          gotCollectionData = true;
          role = "doctor";
          BlocProvider.of<DoctorCubit>(context)
              .updateDoctorModel(singleDoctorModel: DoctorModel.fromMap(data));
        });
      }
    }
    if (gotCollectionData == false) {
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          log("${documentSnapshot.data()}", name: "patient data");

          data = documentSnapshot.data() as Map<String, dynamic>;
        }
      });
      if (data.isNotEmpty) {
        if (context.mounted) {
          setState(() {
            gotCollectionData = true;
            role = "patient";
          });
          BlocProvider.of<PatientCubit>(context).updatePatientModel(
              singlePatientModel: PatientModel.fromMap(data));
        }
      }
    }
    if (context.mounted) {
      BlocProvider.of<UserCubit>(context).updateUserModel(
        email: FirebaseAuth.instance.currentUser!.email.toString(),
        uid: FirebaseAuth.instance.currentUser!.uid.toString(),
        displayName: FirebaseAuth.instance.currentUser!.displayName.toString(),
        photoUrl: FirebaseAuth.instance.currentUser!.photoURL.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });

    if (gotCollectionData && role == "doctor" && isLoading == false) {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DoctorLandingScreen()),
          (route) => false, // Close all existing routes
        );
      }
    } else if (gotCollectionData && role == "patient" && isLoading == false) {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PatientLandingScreen()),
          (route) => false, // Close all existing routes
        );
      }
      return PatientLandingScreen();
    } else if (role == "" && isLoading == false) {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => RegisterUserRoleScreen()),
          (route) => false, // Close all existing routes
        );
      }
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BoardingScreen()),
        (route) => false, // Close all existing routes
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
