import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/components/quantity_selector.dart';
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
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(
                    width: 5,
                  ),
                  // Name and price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.food.name),
                      Text("RM${cartItem.food.price.toString()}"),
                      const SizedBox(height: 10,),
                      QuantitySelector(
                          quantity: cartItem.quantity,
                          food: cartItem.food,
                          onIncrement: () {
                            restaurant.addToCart(
                                cartItem.food, cartItem.selectedAddons);
                          },
                          onDecrement: () {
                            restaurant.removeFromCart(cartItem);
                          }), 
                    ],
                  ),
                  Spacer(),
                  // Increment or decrement quantity
                ],
              ),
            ),
            SizedBox(
              height: cartItem.selectedAddons.isEmpty ? 0 : 60,
              child: ListView(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 10,
                  right: 10,
                ),
                scrollDirection: Axis.horizontal,
                children: cartItem.selectedAddons
                    .map((addon) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Row(
                              children: [
                                Text(addon.name),
                                Text(' RM' + addon.price.toString()),
                              ],
                            ),
                            shape: StadiumBorder(
                                side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                            onSelected: (value) {},
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            labelStyle: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 12,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
