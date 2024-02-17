import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DoctorLandingScreen extends StatefulWidget {
  @override
  _DoctorLandingScreenState createState() => _DoctorLandingScreenState();
}

class _DoctorLandingScreenState extends State<DoctorLandingScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 3
          ? Center(child: Text("Profile"))
          : Center(child: Text("Other")),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: _currentIndex == 0
                        ? null
                        : Colors.blue.withOpacity(0.2)),
                child: const Icon(
                  Icons.home,
                  color: Colors.blue,
                )),
            title: const Text(
              "Home",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: _currentIndex == 1
                        ? null
                        : Colors.blue.withOpacity(0.2)),
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.blue,
                )),
            title: const Text(
              "Likes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: _currentIndex == 2
                        ? null
                        : Colors.blue.withOpacity(0.2)),
                child: const Icon(
                  Icons.search,
                  color: Colors.blue,
                )),
            title: const Text(
              "Search",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:
                      _currentIndex == 3 ? null : Colors.blue.withOpacity(0.2)),
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
    );
  }
}
