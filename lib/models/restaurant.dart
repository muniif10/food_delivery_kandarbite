import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/models/cart_item.dart';
import 'package:food_delivery_kandarbite/models/food.dart';
import 'package:intl/intl.dart';

class Restaurant extends ChangeNotifier {
  // List of food menu

  final List<Food> _menu = [
    // nasi
    Food(
        name: "Nasi Kandar Padu",
        description:
            "Well cooked rice, paired with juicy friend chicken, and everything bathed in variety of tasty and aromatic 'kuah'",
        imagePath: "lib/assets/images/nasi/nasi_kandar_biasa.jpg",
        price: 7,
        category: FoodCategory.nasi,
        availableAddons: [
          Addon(name: "Extra Chicken", price: 5),
          Addon(name: "Sayur", price: 1),
          Addon(name: "Papadom", price: 1),
        ]),
    Food(
        name: "Nasi Briyani",
        description: "Well cooked rice, paired with juicy friend chicken.",
        imagePath: "lib/assets/images/nasi/nasi_briyani.jpg",
        price: 9,
        category: FoodCategory.nasi,
        availableAddons: [
          Addon(name: "Extra Chicken", price: 5),
          Addon(name: "Sayur", price: 1),
          Addon(name: "Papadom", price: 1),
        ]),
    Food(
        name: "Nasi Kabsah",
        description: "Well cooked rice, paired with juicy friend chicken.",
        imagePath: "lib/assets/images/nasi/nasi_kabsa_ayam.jpg",
        price: 11,
        category: FoodCategory.nasi,
        availableAddons: [
          Addon(name: "Extra Chicken", price: 5),
          Addon(name: "Sayur", price: 1),
          Addon(name: "Papadom", price: 1),
        ]),
    Food(
        name: "Milo",
        description: "Air milo, apa lagi hang nak poen",
        imagePath: "lib/assets/images/drinks/milo_ais.jpeg",
        price: 3,
        category: FoodCategory.minuman,
        availableAddons: [
          Addon(name: "Ais", price: .5),
          Addon(name: "Mangkuk", price: 1),
        ]),
  ];

// Getters
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;

// Operations

// User Cart
  final List<CartItem> _cart = [];

// Add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    // See if there is already item in the cart with the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if item same
      bool isSameFood = item.food == food;
      // check if selected addon same
      bool isSameAddon =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddon;
    });
    // If item already exist,
    if (cartItem != null) {
      cartItem.quantity++;
    }
    // Else add item to cart
    else {
      _cart.add(CartItem(
        food: food,
        selectedAddons: selectedAddons,
      ));
    }
    notifyListeners();
  }

// Remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

// get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

// get total number of item
  int getTotalNumberOfItem() {
    int itemTotalCount = 0;
    for (CartItem cartItem in _cart) {
      itemTotalCount += cartItem.quantity;
    }
    return itemTotalCount;
  }

// clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
// Helpers

// Generate receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("KandarBite Receipt");
    receipt.writeln();

    String formattedDate =
        DateFormat('HH:mm:ss dd-MM-yyyy').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("------- Item --------");
  
    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.food.name} (RM${cartItem.food.price})");
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln("Add-ons ${_formatAddon(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }
    receipt.writeln("------- Summary --------");
    receipt.writeln("Total number of item: ${getTotalNumberOfItem()}");
    receipt.writeln("Total Items: ${_formatPrice(getTotalPrice())}");
    return receipt.toString();
  }

  // format stuff

  String _formatPrice(double price) {
    return "RM${price.toStringAsFixed(2)}";
  }

  String _formatAddon(List<Addon> addons) {
    return addons
        .map((addon) => "\n${addon.name} (${_formatPrice(addon.price)})")
        .join();
  }
}
