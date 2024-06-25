
import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/components/custom_button.dart';
import 'package:food_delivery_kandarbite/models/food.dart';
import 'package:food_delivery_kandarbite/models/restaurant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  FoodPage({
    super.key,
    required this.food,
  }) {
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }
  final Food food;
  final Map<Addon, bool> selectedAddons = {};

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    Navigator.pop(context);
    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }
    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    double addonTotal = 0;
    for (MapEntry<Addon, bool> entry in widget.selectedAddons.entries) {
      if (entry.value == true) {
        addonTotal += entry.key.price;
      }
    }
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Food image
                Image.asset(
                  widget.food.imagePath,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Food name
                      Text(
                        widget.food.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      //
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'RM ${widget.food.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          addonTotal > 0.0
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8),
                                  child: Text(
                                    "+ RM${addonTotal.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary),
                                  ),
                                )
                              : Container(),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      // Food description

                      Text(
                        widget.food.description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                      ),

                      Text(
                        "Add-ons",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Addons
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: widget.food.availableAddons.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Addon addon = widget.food.availableAddons[index];
                              return CheckboxListTile(
                                title: Text(addon.name),
                                subtitle: Text(
                                  'RM${addon.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                value: widget.selectedAddons[addon],
                                onChanged: (bool? value) {
                                  setState(() {
                                    widget.selectedAddons[addon] = value!;
                                  });
                                },
                              );
                            }),
                      )
                    ],
                  ),
                )
                // Add to cart button
                ,
                CustomButton(
                    onTap: () {
                      addToCart(widget.food, widget.selectedAddons);
                    },
                    text: "Add to cart"),
                const SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ),
        SafeArea(
          child: Opacity(
            opacity: 0.6,
            child: Container(
              margin: const EdgeInsets.only(left: 25),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
          ),
        )
      ],
    );
  }
}
