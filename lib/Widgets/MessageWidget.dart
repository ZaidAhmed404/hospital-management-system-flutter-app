import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';

void messageWidget(
    {required BuildContext context,
    required bool isError,
    required String message}) {
  return FloatingSnackBar(
    message: message,
    context: context,
    textColor: Colors.black,
    textStyle: const TextStyle(color: Colors.white),
    duration: const Duration(milliseconds: 4000),
    backgroundColor: isError ? Colors.red : Colors.green,
  );
}
