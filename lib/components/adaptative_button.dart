import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String? label;
  final Function()? onPressed;

  const AdaptativeButton({
    this.label,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          primary: Theme.of(context).colorScheme.secondary,
        ),
        onPressed: onPressed,
        child: Text(
          label!,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
