import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  final String message;
  final String time;
  final String imageUrl;
  bool condition;

  ChatWidget(
      {super.key,
      required this.message,
      required this.time,
      required this.imageUrl,
      required this.condition});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (condition)
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 20.0,
            ),
          if (condition) const SizedBox(width: 10.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 10, right: 15, left: 15),
              decoration: BoxDecoration(
                color: condition ? Colors.blueAccent : Colors.greenAccent,
                // Attractive color
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                    bottomRight: condition
                        ? const Radius.circular(20.0)
                        : const Radius.circular(0.0),
                    bottomLeft: condition
                        ? const Radius.circular(0.0)
                        : const Radius.circular(20.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        time,
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (!condition) const SizedBox(width: 10.0),
          if (!condition)
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 20.0,
            ),
        ],
      ),
    );
  }
}
