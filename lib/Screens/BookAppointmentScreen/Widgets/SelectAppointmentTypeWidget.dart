import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SelectAppointmentTypeWidget extends StatefulWidget {
  SelectAppointmentTypeWidget(
      {super.key,
      required this.selectedType,
      required this.onTypeSelectedFunction});

  String selectedType;
  Function(String) onTypeSelectedFunction;

  @override
  State<SelectAppointmentTypeWidget> createState() =>
      _SelectAppointmentTypeWidgetState();
}

class _SelectAppointmentTypeWidgetState
    extends State<SelectAppointmentTypeWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              "Appointment Type",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => widget.onTypeSelectedFunction("Message"),
              child: Container(
                width: width * 0.25,
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                    color: (widget.selectedType == "Message")
                        ? Colors.blue
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue)),
                alignment: Alignment.center,
                child: Text(
                  "Message",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: (widget.selectedType == "Message")
                          ? Colors.white
                          : Colors.blue),
                ),
              ),
            ),
            InkWell(
              onTap: () => widget.onTypeSelectedFunction("Audio Call"),
              child: Container(
                width: width * 0.25,
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                    color: (widget.selectedType == "Audio Call")
                        ? Colors.blue
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue)),
                alignment: Alignment.center,
                child: Text(
                  "Audio Call",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: (widget.selectedType == "Audio Call")
                          ? Colors.white
                          : Colors.blue),
                ),
              ),
            ),
            InkWell(
              onTap: () => widget.onTypeSelectedFunction("Video Call"),
              child: Container(
                width: width * 0.25,
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                    color: (widget.selectedType == "Video Call")
                        ? Colors.blue
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue)),
                alignment: Alignment.center,
                child: Text(
                  "Video Call",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: (widget.selectedType == "Video Call")
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
