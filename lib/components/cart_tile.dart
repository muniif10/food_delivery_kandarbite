import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/components/quantity_selector.dart';
import 'package:food_delivery_kandarbite/models/cart_item.dart';
import 'package:food_delivery_kandarbite/models/restaurant.dart';
import 'package:provider/provider.dart';

class CartTile extends StatefulWidget {
  const CartTile({super.key, required this.cartItem});
  final CartItem cartItem;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
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
                      widget.cartItem.food.imagePath,
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
                      Text(widget.cartItem.food.name),
                      Text(
                          "RM${widget.cartItem.food.price.toStringAsFixed(2)}"),
                      const SizedBox(
                        height: 10,
                      ),
                      QuantitySelector(
                          quantity: widget.cartItem.quantity,
                          food: widget.cartItem.food,
                          onIncrement: () {
                            restaurant.addToCart(widget.cartItem.food,
                                widget.cartItem.selectedAddons);
                          },
                          onDecrement: () {
                            restaurant.removeFromCart(widget.cartItem);
                          }),
                    ],
                  ),
                  const Spacer(),
                  // Increment or decrement quantity
                ],
              ),
            ),
            SizedBox(
              height: widget.cartItem.selectedAddons.isEmpty ? 0 : 60,
              child: ListView(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 10,
                  right: 10,
                ),
                scrollDirection: Axis.horizontal,
                children: widget.cartItem.selectedAddons
                    .map((addon) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Row(
                              children: [
                                Text(addon.name),
                                Text(' RM${addon.price}'),
                              ],
                            ),
                            shape: StadiumBorder(
                                side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                            onSelected: (value) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title:
                                      Text("Do you want delete this add-on?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No")),
                                    TextButton(
                                        onPressed: () {
                                          widget.cartItem.selectedAddons
                                              .remove(addon);
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: Text("Yes"))
                                  ],
                                ),
                              );
                            },
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
