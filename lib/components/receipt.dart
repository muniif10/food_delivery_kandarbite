import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/models/restaurant.dart';
import 'package:provider/provider.dart';

class Receipt extends StatelessWidget {
  const Receipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: Column(
        children: [
          const Text("Thanks for your order"),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                    color: (Colors.grey[300])!,
                    blurRadius: 5,
                    offset: const Offset(1, 2))
              ],
              border:
                  Border.all(color: Theme.of(context).colorScheme.secondary),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(25),
            child: Consumer<Restaurant>(
              builder: (context, restaurant, child) => Text(
                restaurant.displayCartReceipt(),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
