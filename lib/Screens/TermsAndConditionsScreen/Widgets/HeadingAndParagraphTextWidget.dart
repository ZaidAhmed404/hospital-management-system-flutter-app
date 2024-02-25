import 'package:flutter/material.dart';

class HeadingAndParagraphTextWidget extends StatelessWidget {
  HeadingAndParagraphTextWidget(
      {super.key, required this.headingText, required this.paragraphText});

  String headingText;
  String paragraphText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headingText,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          Text(
            paragraphText,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
