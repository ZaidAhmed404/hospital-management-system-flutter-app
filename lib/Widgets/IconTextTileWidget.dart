import 'package:flutter/material.dart';

class IconTextTileWidget extends StatelessWidget {
  IconData firstIcon;
  IconData secondIcon;
  Color iconColor;
  Color iconBackgroundColor;
  String text;
  Function onPressedFunction;
  bool haveSecondIcon;

  IconTextTileWidget(
      {super.key,
      required this.text,
      required this.onPressedFunction,
      required this.firstIcon,
      required this.secondIcon,
      required this.iconBackgroundColor,
      required this.iconColor,
      required this.haveSecondIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressedFunction(),
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: iconBackgroundColor),
              child: Icon(
                firstIcon,
                color: iconColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            if (haveSecondIcon)
              Icon(
                secondIcon,
                color: Colors.grey,
                size: 20,
              )
          ],
        ),
      ),
    );
  }
}
