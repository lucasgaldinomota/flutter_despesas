import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String? label;
  final Function()? onPressed;

  const AdaptativeButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Colors.pink[700],
            child: Text(label.toString()),
            onPressed: onPressed,
          )
        : FloatingActionButton(
            backgroundColor: Colors.pink[600],
            child: const Icon(
              Icons.check,
              size: 40,
              color: Colors.white,
            ),
            onPressed: onPressed,
          );
  }
}
