import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/pages/cart_page.dart';

class CustomSliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;

  const CustomSliverAppBar({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      
      snap: false,
      centerTitle: true,
      expandedHeight: 300,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        // Icon button
        IconButton(
            onPressed: () {
              // go to cart
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const CartPage();
                },
              ));
            },
            icon: const Icon(Icons.shopping_cart))
      ],
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("KandarBite"),
      flexibleSpace: FlexibleSpaceBar(
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        background: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: child,
        ),
      ),
    );
  }
}
