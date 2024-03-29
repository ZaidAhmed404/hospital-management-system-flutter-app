import 'package:flutter/material.dart';

class PickDataWidget extends StatefulWidget {
  PickDataWidget(
      {super.key, required this.onPressedFunction, required this.pickedDate});

  DateTime? pickedDate;
  Function() onPressedFunction;

  @override
  State<PickDataWidget> createState() => _PickDataWidgetState();
}

class _PickDataWidgetState extends State<PickDataWidget> {
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
              "Date",
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
                  widget.pickedDate != null
                      ? "${widget.pickedDate!.day}-${widget.pickedDate!.month}-${widget.pickedDate!.year}"
                      : "Date",
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
