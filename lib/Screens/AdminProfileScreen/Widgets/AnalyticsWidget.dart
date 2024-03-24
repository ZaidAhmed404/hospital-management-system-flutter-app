import 'package:flutter/material.dart';

import '../../../main.dart';

class AnalyticsWidget extends StatelessWidget {
  AnalyticsWidget(
      {super.key,
      required this.height,
      required this.firstText,
      required this.secondText});

  double height;
  String firstText;
  String secondText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            firstText,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: height * appConstants.fontSize14),
          ),
          Text(
            secondText,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: height * appConstants.fontSize14),
          ),
        ],
      ),
    );
  }
}
