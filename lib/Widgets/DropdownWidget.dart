import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  List<String> list;
  String selectedValue;
  Function(String) onPressedFunction;
  String title;

  DropdownWidget(
      {super.key,
      required this.onPressedFunction,
      required this.list,
      required this.selectedValue,
      required this.title});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              widget.title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
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
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.black12),
              borderRadius: BorderRadius.circular(50)),
          child: DropdownButton<String>(
            style: const TextStyle(fontSize: 12, color: Colors.black),
            value: widget.selectedValue,
            icon: const Icon(Icons.arrow_drop_down_outlined),
            onChanged: (String? value) {
              setState(() {
                widget.selectedValue = value!;
              });
              widget.onPressedFunction(widget.selectedValue);
            },
            isExpanded: true,
            underline: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            items: widget.list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
