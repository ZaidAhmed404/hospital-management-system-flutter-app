import 'package:doctor_patient_management_system/main.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/ButtonWidget.dart';

class DeleteMedicineDialogWidget extends StatelessWidget {
  DeleteMedicineDialogWidget({super.key, required this.docId});

  String docId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Delete",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Are you sure, you want to delete this medicine?",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
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
                    onPressedFunction: () {
                      Navigator.pop(context);
                    }),
                ButtonWidget(
                    buttonText: "Ok",
                    buttonWidth: MediaQuery.of(context).size.width * 0.35,
                    buttonColor: Colors.blueAccent,
                    borderColor: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressedFunction: () async {
                      await appConstants.medicineServices
                          .delete(docId: docId, context: context);
                      Navigator.pop(context);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
