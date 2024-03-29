import 'package:flutter/material.dart';
import '../../../Widgets/ButtonWidget.dart';
import '../WelcomeScreen/WelcomeScreen.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  List<Map> boarding = [
    {
      "image": "assets/images/boarding 1.jpg",
      "heading": "Thousands of doctors",
      "description":
          "You can easily contact with a thousands of Doctors and contact for you need"
    },
    {
      "image": "assets/images/boarding 2.jpg",
      "heading": "Chat With doctors",
      "description":
          "Book an appointment with doctor. Chat with doctor via appointment letter and get consultation"
    },
    {
      "image": "assets/images/boarding 3.jpg",
      "heading": "Live talk with doctor",
      "description":
          "Easily Contact with Doctor, start voice and video call for your better treatment and prescription"
    },
  ];

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {},
            itemCount: boarding.length + 1,
            itemBuilder: (_, index) {
              return index == boarding.length
                  ? const WelcomeScreen()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(boarding[index]['image']))),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                boarding[index]['heading'],
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.blue),
                              ),
                              Text(
                                boarding[index]['description'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < boarding.length; i++)
                                    Container(
                                      width: 5,
                                      height: 5,
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: (i == index)
                                              ? Colors.black
                                              : Colors.black12,
                                          shape: BoxShape.circle),
                                    )
                                ],
                              ),
                              TextButton(
                                  onPressed: () {
                                    _pageController.jumpToPage(boarding.length);
                                  },
                                  child: const Text(
                                    "Skip",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )),
                              ButtonWidget(
                                  buttonText: "Next",
                                  buttonWidth:
                                      MediaQuery.of(context).size.width,
                                  buttonColor: Colors.blueAccent,
                                  borderColor: Colors.blueAccent,
                                  textColor: Colors.white,
                                  onPressedFunction: () {
                                    _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    );
            }));
  }
}
