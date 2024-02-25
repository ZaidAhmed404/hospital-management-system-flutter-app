import 'package:flutter/material.dart';

class FAQWidget extends StatefulWidget {
  FAQWidget({super.key, required this.answer, required this.question});

  String question;
  String answer;

  @override
  State<FAQWidget> createState() => _FAQWidgetState();
}

class _FAQWidgetState extends State<FAQWidget> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
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
            border: Border.all(color: isShow ? Colors.blue : Colors.grey)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                    maxLines: 10,
                    widget.question,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                ),
                Icon(isShow ? Icons.arrow_drop_up : Icons.arrow_drop_down)
              ],
            ),
            if (isShow) const Divider(),
            if (isShow)
              Text(
                widget.answer,
                style: const TextStyle(fontSize: 15),
              ),
          ],
        ),
      ),
    );
  }
}
