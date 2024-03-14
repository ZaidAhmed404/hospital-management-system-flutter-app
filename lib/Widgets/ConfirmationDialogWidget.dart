import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/ButtonWidget.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  ConfirmationDialogWidget(
      {super.key,
      required this.message,
      required this.onCancelFunction,
      required this.onConfirmFunction,
      required this.title});

  String title;
  String message;
  Function() onConfirmFunction;
  Function() onCancelFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              message,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonWidget(
                    buttonText: "Cancel",
                    buttonWidth: MediaQuery.of(context).size.width * 0.35,
                    buttonColor: Colors.white,
                    borderColor: Colors.blueAccent,
                    textColor: Colors.blueAccent,
                    onPressedFunction: () => onCancelFunction()),
                ButtonWidget(
                    buttonText: "Ok",
                    buttonWidth: MediaQuery.of(context).size.width * 0.35,
                    buttonColor: Colors.blueAccent,
                    borderColor: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressedFunction: () => onConfirmFunction()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
