import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onSubmitted;

  const AdaptativeTextField({
    this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white70,
          // fontWeight: FontWeight.bold,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
