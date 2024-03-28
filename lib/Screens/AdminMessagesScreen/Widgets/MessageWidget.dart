import 'package:flutter/material.dart';

import '../../../Models/MessageModel.dart';
import '../../../main.dart';

class MessageWidget extends StatefulWidget {
  MessageWidget({super.key, required this.message});

  MessageModel message;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        if (isShow == true) {
          isShow = false;
        } else {
          isShow = true;
        }
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                    maxLines: 10,
                    widget.message.subject,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: height * appConstants.fontSize18),
                  ),
                ),
                Icon(isShow ? Icons.arrow_drop_up : Icons.arrow_drop_down)
              ],
            ),
            if (isShow) const Divider(),
            if (isShow)
              Text(
                widget.message.message,
                style: const TextStyle(fontSize: 15),
              ),
            if (isShow) const Divider(),
            if (isShow)
              Text(
                widget.message.name,
                style: const TextStyle(fontSize: 15),
              ),
            if (isShow) const Divider(),
            if (isShow)
              Text(
                widget.message.email,
                style: const TextStyle(fontSize: 15),
              ),
            if (isShow) const Divider(),
            if (isShow)
              Text(
                widget.message.role,
                style: const TextStyle(fontSize: 15),
              ),
          ],
        ),
      ),
    );
  }
}
