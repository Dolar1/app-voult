import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  final String initVal;
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;
  int min;
  int max;
  final bool enabled;

  CustomTextField({
    this.hint,
    this.textEditingController,
    this.keyboardType,
    this.icon,
    this.min = 1,
    this.max = 1,
    this.obscureText = false,
    this.enabled,
    this.initVal,
  });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Material(
      child: TextFormField(
        textAlign: TextAlign.left,
        maxLines: max,
        minLines: min,
        initialValue: initVal,
        enabled: enabled,
        obscureText: obscureText,
        controller: textEditingController,
        keyboardType: keyboardType,
        cursorColor: Colors.greenAccent,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.greenAccent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.7),
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}
