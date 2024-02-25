import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key, required this.backPressedFunction});

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
                  "Privacy Policy",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Welcome to Sehat Sakoon! This Privacy Policy outlines our commitment to safeguarding your privacy by explaining how we collect, use, and protect your personal information. When you use our app, we collect data such as user account information, health information for facilitating virtual consultations, device information, and usage patterns to enhance and personalize your experience. Your information may be shared with healthcare professionals and third-party service providers for the purpose of delivering and improving our services. We prioritize the security of your data, implementing industry-standard measures to prevent unauthorized access. You have control over your account settings and communication preferences. We retain your information only for as long as necessary and reserve the right to update this Privacy Policy. If you have any questions or concerns, please contact us at [Your Contact Information].",
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
