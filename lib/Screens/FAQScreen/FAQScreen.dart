import 'package:doctor_patient_management_system/Screens/FAQScreen/Widgets/FAQWidget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({super.key, required this.backPressedFunction});

  Function(int) backPressedFunction;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: IconButton(
                      onPressed: () => backPressedFunction(0),
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.blue,
                      )),
                ),
                const Spacer(),
                Text(
                  "FAQs",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: height * appConstants.fontSize20),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FAQWidget(
                answer:
                    "Sehat Sakoon is a multifaceted healthcare platform that enables users to schedule virtual appointments with doctors, receive digital prescriptions, access health news and articles, communicate with healthcare providers in real-time, securely make payments, manage appointments, and coordinate medicine deliveries from local pharmacies",
                question: "What is Sehat Sakoon?"),
            FAQWidget(
                answer:
                    "Booking a consultation is easy! Simply download the Sehat Sakoon app, create an account, and then navigate to the Book Appointment section. From there, you can select the specialty of the doctor you wish to consult with, choose a convenient time slot, and proceed to book your appointment.",
                question:
                    "How do I book a consultation with a doctor through Sehat Sakoon?"),
            FAQWidget(
                answer:
                    "What types of doctors are available for consultation on Sehat Sakoon?",
                question:
                    "What types of doctors are available for consultation on Sehat Sakoon?"),
            FAQWidget(
                answer:
                    "What types of doctors are available for consultation on Sehat Sakoon?",
                question:
                    "What types of doctors are available for consultation on Sehat Sakoon?"),
            FAQWidget(
                answer:
                    "What types of doctors are available for consultation on Sehat Sakoon?",
                question:
                    "What types of doctors are available for consultation on Sehat Sakoon?"),
            FAQWidget(
                answer:
                    "What types of doctors are available for consultation on Sehat Sakoon?",
                question:
                    "What types of doctors are available for consultation on Sehat Sakoon?"),
            FAQWidget(
                answer:
                    "What types of doctors are available for consultation on Sehat Sakoon?",
                question:
                    "What types of doctors are available for consultation on Sehat Sakoon?"),
          ],
        ),
      ),
    );
  }
}
