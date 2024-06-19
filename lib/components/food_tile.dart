import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/models/food.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({
    required this.onTap,
    super.key,
    required this.food,
  });
  final Food food;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Material(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "RM ${food.price.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        food.description,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      food.imagePath,
                      width: 120,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.primary,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
