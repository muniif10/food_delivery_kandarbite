import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/models/cart_item.dart';
import 'package:food_delivery_kandarbite/models/restaurant.dart';
import 'package:food_delivery_kandarbite/pages/cart_page.dart';
import 'package:provider/provider.dart';

class PastOrderTile extends StatelessWidget {
  const PastOrderTile({
    super.key,
    required this.dateString,
    required this.receipt,
    required this.cartDetail,
  });

  final String dateString;
  final Map<String, dynamic> receipt;
  final List<CartItem> cartDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                dateString,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Theme.of(context).colorScheme.surface,
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(receipt["order"])),
              ),
            ),
            // ...cartDetail.map(
            //   (e) => Text(e.food.name),
            // ),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Cart will be cleared"),
                      content: const Text(
                          "This will clear the current cart and replace it with that past order."),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Back")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context
                                  .read<Restaurant>()
                                  .replaceCart(cartDetail);
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CartPage(),
                              ));
                            },
                            child: const Text("Confirm")),
                      ],
                    ),
                  );
                },
                child: const Text("Order again?"))
          ],
        ),
      ),
    );
  }
}
