import 'package:flutter/material.dart';

class CustomDescriptionBox extends StatelessWidget {
  const CustomDescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    var myPrimaryStyle = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
    );
    var mySecondaryStyle = TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold);
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Delivery Fee
          Column(
            children: [
              Text(
                "RM4.00",
                style: myPrimaryStyle,
              ),
              Text("Delivery fee", style: mySecondaryStyle)
            ],
          ),
          Column(
            children: [
              Text(
                "15-30 Minutes",
                style: myPrimaryStyle,
              ),
              Text("Delivery time", style: mySecondaryStyle)
            ],
          ),
          // Delivery Time
        ],
      ),
    );
  }
}
