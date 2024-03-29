import 'package:flutter/material.dart';

import '../../../main.dart';

class SelectTimeSlotWidget extends StatefulWidget {
  SelectTimeSlotWidget(
      {super.key,
      required this.selectedSlot,
      required this.onSlotSelectedFunction});

  String selectedSlot;
  Function(String) onSlotSelectedFunction;

  @override
  State<SelectTimeSlotWidget> createState() => _SelectTimeSlotWidgetState();
}

class _SelectTimeSlotWidgetState extends State<SelectTimeSlotWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              "Time Slot",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: height * appConstants.fontSize14,
                  color: Colors.black54),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "*",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => widget.onSlotSelectedFunction("30 Minutes"),
              child: Container(
                width: width * 0.4,
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                    color: (widget.selectedSlot == "30 Minutes")
                        ? Colors.blue
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue)),
                alignment: Alignment.center,
                child: Text(
                  "30 Minutes",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: height * appConstants.fontSize14,
                      color: (widget.selectedSlot == "30 Minutes")
                          ? Colors.white
                          : Colors.blue),
                ),
              ),
            ),
            InkWell(
              onTap: () => widget.onSlotSelectedFunction("1 Hour"),
              child: Container(
                width: width * 0.4,
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                    color: (widget.selectedSlot == "1 Hour")
                        ? Colors.blue
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue)),
                alignment: Alignment.center,
                child: Text(
                  "1 Hour",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: height * appConstants.fontSize14,
                      color: (widget.selectedSlot == "1 Hour")
                          ? Colors.white
                          : Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
