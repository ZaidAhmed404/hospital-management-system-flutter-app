import 'package:flutter/material.dart';

import '../../../Models/OrderMedicines.dart';
import '../../../Widgets/ButtonWidget.dart';
import '../../../Widgets/TextFieldWidget.dart';
import '../../../main.dart';

class ChangeOrderStatusDialogWidget extends StatefulWidget {
  ChangeOrderStatusDialogWidget({super.key, required this.docId});

  String docId;

  @override
  State<ChangeOrderStatusDialogWidget> createState() =>
      _ChangeOrderStatusDialogWidgetState();
}

class _ChangeOrderStatusDialogWidgetState
    extends State<ChangeOrderStatusDialogWidget> {
  final TextEditingController ticketNumberController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Change Status",
              style: TextStyle(
                  fontSize: height * appConstants.fontSize20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Change Status to",
                  style: TextStyle(
                      fontSize: height * appConstants.fontSize14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "On Way",
                  style: TextStyle(
                      fontSize: height * appConstants.fontSize14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              hintText: "TCS CN Number",
              text: "TCS CN Number",
              controller: ticketNumberController,
              isPassword: false,
              isEnabled: true,
              validationFunction: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ticket Number is required';
                }
                return null;
              },
              textInputType: TextInputType.number,
              textFieldWidth: MediaQuery.of(context).size.width,
              haveText: true,
              onValueChange: (value) {},
              maxLines: 1,
              borderCircular: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : ButtonWidget(
                    buttonText: "Save",
                    buttonWidth: MediaQuery.of(context).size.width,
                    buttonColor: Colors.blueAccent,
                    borderColor: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressedFunction: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await appConstants.medicineServices.changeStatus(
                          status: "On Way",
                          docId: widget.docId,
                          ticketNumber: ticketNumberController.text.trim(),
                          context: context);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
