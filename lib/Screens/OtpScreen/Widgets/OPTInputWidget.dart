import 'package:flutter/material.dart';

class OtpInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;

  OtpInputWidget({
    required this.autoFocus,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      height: 50,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black),
      ),
      alignment: Alignment.center,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        style: const TextStyle(color: Colors.black),
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
