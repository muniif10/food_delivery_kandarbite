import 'package:food_delivery_kandarbite/models/food.dart';

class CartItem {
  Food food;
  List<Addon> selectedAddons;
  int quantity;

  CartItem({
    required this.food,
    required this.selectedAddons,
    this.quantity = 1,
  });

  double get totalPrice {
    double addonPrice = selectedAddons.fold(0, (sum, addon) => sum + addon.price);
    return (food.price + addonPrice) * quantity;
  }

  Map<String, dynamic> toMap() {
    return {
      'food': food.toMap(),
      'selectedAddons': selectedAddons.map((addon) => addon.toMap()).toList(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      food: Food.fromMap(map['food']),
      selectedAddons: List<Addon>.from(map['selectedAddons'].map((addon) => Addon.fromMap(addon))),
      quantity: map['quantity'],
    );
  }
}