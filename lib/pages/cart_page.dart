import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/components/cart_tile.dart';
import 'package:food_delivery_kandarbite/components/custom_button.dart';
import 'package:food_delivery_kandarbite/models/restaurant.dart';
import 'package:food_delivery_kandarbite/pages/payment_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        final userCart = restaurant.cart;

        return Scaffold(
          appBar: AppBar(
            actions: [
              // clear cart
              userCart.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                                "Are you sure you want to clear the cart?"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    restaurant.clearCart();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Accept")),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                      ))
                  : const SizedBox(),
              //
            ],
            title: const Text("Cart"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Column(
            children: [
              // List of cart item
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ? const Expanded(
                            child: Center(
                            child: Text("Cart is empty..."),
                          ))
                        : Expanded(
                            child: ListView.builder(
                            itemCount: userCart.length,
                            itemBuilder: (context, index) {
                              // get invidual cart item
                              final cartItem = userCart[index];
                              // return cart tile UI
                              return CartTile(cartItem: cartItem);
                            },
                          ))
                  ],
                ),
              ),
              CustomButton(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PaymentPage(),
                    ));
                  },
                  text: "Go to checkout"),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        );
      },
    );
  }
}
