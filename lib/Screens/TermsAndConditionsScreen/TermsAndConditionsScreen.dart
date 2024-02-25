import 'package:flutter/material.dart';

import 'Widgets/HeadingAndParagraphTextWidget.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  TermsAndConditionsScreen({super.key, required this.backPressedFunction});

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
                const Text(
                  "Terms and Conditions",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            HeadingAndParagraphTextWidget(
              headingText: "1. Introduction",
              paragraphText:
                  "Welcome to Sehat Sakoon! By accessing and using our app, you agree to comply with and be bound by these terms and conditions. If you do not agree with any part of these terms, please do not use the app.",
            ),
            HeadingAndParagraphTextWidget(
                headingText: "2. User Eligibility",
                paragraphText:
                    "You must be at least 18 years old to use Sehat Sakoon. Users outside the specified geographical areas may not be eligible to use the app."),
            HeadingAndParagraphTextWidget(
                headingText: "3. User Accounts",
                paragraphText:
                    "To access certain features of the app, you may be required to create an account. You are responsible for maintaining the confidentiality of your account information. We reserve the right to suspend or terminate accounts for violation of these terms."),
            HeadingAndParagraphTextWidget(
                headingText: "4. Doctor-Patient Relationship",
                paragraphText:
                    "Sehat Sakoon facilitates connections between doctors and patients, but it does not establish a traditional in-person doctor-patient relationship. The app is not intended for emergency situations."),
            HeadingAndParagraphTextWidget(
                headingText: "5. Use of the App",
                paragraphText:
                    "You agree to use the app in accordance with applicable laws and regulations. Misuse of the app may result in consequences, including account suspension or termination."),
            HeadingAndParagraphTextWidget(
                headingText: "6. Medical Advice and Information",
                paragraphText:
                    "Information on Sehat Sakoon is not a substitute for professional medical advice. Users should consult with qualified healthcare professionals for specific medical concerns."),
            HeadingAndParagraphTextWidget(
                headingText: "7. Communication on the Platform",
                paragraphText:
                    "Users must adhere to guidelines for communication within the app. Inappropriate content is prohibited. We reserve the right to monitor and moderate user interactions."),
            HeadingAndParagraphTextWidget(
                headingText: "8. Fees and Payments",
                paragraphText:
                    "Certain features of the app may involve fees. By using these features, you agree to the associated fees and payment terms."),
            HeadingAndParagraphTextWidget(
                headingText: "9. Contact Information",
                paragraphText:
                    "For questions or support, contact us at [Your Contact Information]."),
          ],
        ),
      ),
    );
  }
}
