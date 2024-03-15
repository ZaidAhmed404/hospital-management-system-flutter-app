import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../AdminDoctorScreen/AdminDoctorScreen.dart';
import '../AdminMedicineScreen/AdminMedicineScreen.dart';
import '../AdminProfileScreen/AdminProfileScreen.dart';

class AdminLandingScreen extends StatefulWidget {
  const AdminLandingScreen({super.key});

  @override
  State<AdminLandingScreen> createState() => _AdminLandingScreenState();
}

class _AdminLandingScreenState extends State<AdminLandingScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: _currentIndex == 0
              ? const AdminMedicineScreen()
              : _currentIndex == 1
                  ? const AdminDoctorScreen()
                  : _currentIndex == 2
                      ? const AdminProfileScreen()
                      : const Center(child: Text("Admin login")),
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: _currentIndex == 0
                        ? null
                        : Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                child: const Icon(
                  Icons.medical_information,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "Medicines",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              selectedColor: Colors.blue,
            ),
            SalomonBottomBarItem(
              icon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: _currentIndex == 1
                          ? null
                          : Colors.blue.withOpacity(0.2)),
                  child: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  )),
              title: const Text(
                "Doctors",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              selectedColor: Colors.blue,
            ),
            SalomonBottomBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: _currentIndex == 3
                        ? null
                        : Colors.blue.withOpacity(0.2)),
                child: const Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "Profile",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              selectedColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}