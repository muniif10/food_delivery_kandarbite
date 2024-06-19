import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/models/cart_item.dart';
import 'package:food_delivery_kandarbite/models/restaurant.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile({super.key, required this.cartItem});
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        child: Column(
          children: [
            Row(
              children: [
                // Food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    cartItem.food.imagePath,
                    width: 100,
                    height: 100,
                  ),
                ),
                // Name and price
                
                // Increment or decrement quantity
              ],
            )
          ],
        ),
      ),
    );
  }
}
