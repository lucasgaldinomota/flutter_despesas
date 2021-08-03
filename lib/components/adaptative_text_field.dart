import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

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
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border:
                    Border(bottom: BorderSide(width: 0.4, color: Colors.white)),
              ),
              controller: controller,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              style: TextStyle(color: Colors.white),
              placeholder: label,
              clearButtonMode: OverlayVisibilityMode.editing,
              placeholderStyle: const TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(labelText: label),
            style: const TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          );
  }
}
