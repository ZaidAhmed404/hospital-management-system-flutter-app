import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class PickTimeWidget extends StatefulWidget {
  PickTimeWidget(
      {super.key, required this.onPressedFunction, required this.pickedTime});

  TimeOfDay? pickedTime;
  Function() onPressedFunction;

  @override
  State<PickTimeWidget> createState() => _PickTimeWidgetState();
}

class _PickTimeWidgetState extends State<PickTimeWidget> {
  convert24Into12Hours(TimeOfDay timeOfDay) {
    String timeString = '${timeOfDay.hour}:${timeOfDay.minute}';

    DateFormat parser = DateFormat.Hms();
    DateTime dateTime = parser.parse(timeString);

    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return Text(formattedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              "Time",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.black54),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "*",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () => widget.onPressedFunction(),
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.black12),
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              children: [
                const Icon(Icons.date_range),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.pickedTime != null
                      ? "${(widget.pickedTime!.hour % 12 == 0 ? 12 : widget.pickedTime!.hour % 12).toString().padLeft(2, '0')}:${widget.pickedTime!.minute.toString().padLeft(2, '0')} ${widget.pickedTime!.period.name}"
                      : "Time",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
