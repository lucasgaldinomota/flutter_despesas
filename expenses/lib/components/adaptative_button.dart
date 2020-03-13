import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AdaptativeButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Colors.pink[600],
            child: Text(label),
            onPressed: onPressed,
          )
        : FloatingActionButton(
            backgroundColor: Colors.pink[600],
            child: Icon(
              Icons.check,
              size: 40,
              color: Colors.white,
            ),
            onPressed: onPressed,
          );
  }
}
