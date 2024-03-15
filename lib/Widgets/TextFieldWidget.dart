import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  String text;
  String hintText;
  bool isPassword;
  String? Function(String?) validationFunction;
  bool isEnabled;
  bool haveText;
  TextInputType textInputType;
  double textFieldWidth;
  Function(String?) onValueChange;
  int maxLines;
  double borderCircular;

  TextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.text,
      required this.isPassword,
      required this.validationFunction,
      required this.isEnabled,
      required this.textInputType,
      required this.textFieldWidth,
      required this.haveText,
      required this.onValueChange,
      required this.maxLines,
      required this.borderCircular});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool viewPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewPassword = !widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.textFieldWidth,
      child: Column(
        children: [
          if (widget.haveText)
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  widget.text,
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
          TextFormField(
            controller: widget.controller,
            textInputAction: TextInputAction.done,
            keyboardType: widget.textInputType,
            obscureText: !viewPassword,
            enabled: widget.isEnabled,
            onChanged: widget.onValueChange,
            maxLines: viewPassword ? widget.maxLines : 1,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          viewPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                        onPressed: () {
                          if (viewPassword == true) {
                            viewPassword = false;
                          } else {
                            viewPassword = true;
                          }
                          setState(() {});
                        },
                      )
                    : null,
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(20, 8, 8, 20),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 0.5, color: Colors.black12),
                  borderRadius: BorderRadius.circular(widget.borderCircular),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1.5, color: Colors.blue),
                  borderRadius: BorderRadius.circular(widget.borderCircular),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 0.5, color: Colors.black12),
                  borderRadius: BorderRadius.circular(widget.borderCircular),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1.5, color: Colors.red),
                  borderRadius: BorderRadius.circular(widget.borderCircular),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1.5, color: Colors.red),
                  borderRadius: BorderRadius.circular(widget.borderCircular),
                )),
            validator: widget.validationFunction,
          ),
        ],
      ),
    );
  }
}
