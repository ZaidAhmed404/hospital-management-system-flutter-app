import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String buttonText;
  Color buttonColor;
  Function onPressedFunction;
  Color borderColor;
  Color textColor;

  ButtonWidget({
    super.key,
    required this.onPressedFunction,
    required this.buttonText,
    required this.buttonColor,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressedFunction(),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 2),
            color: buttonColor,
            borderRadius: BorderRadius.circular(30)),
        child: Text(buttonText,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w600, fontSize: 15)),
      ),
    );
  }
}
