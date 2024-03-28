import 'package:flutter/material.dart';

import '../../../main.dart';

class ContactWidget extends StatelessWidget {
  ContactWidget({super.key, required this.contact, required this.icon});

  String contact;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
              padding: const EdgeInsets.all(10),
              child: icon),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              contact,
              style: TextStyle(
                  fontSize: height * appConstants.fontSize16,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
