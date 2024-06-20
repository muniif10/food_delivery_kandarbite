import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  Function()? onDoubleTap;
  final String text;
  CustomButton(
      {super.key, required this.onTap, required this.text, this.onDoubleTap}) {
    onDoubleTap = () {};
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 16),
        ),
      ),
    );
  }
}
