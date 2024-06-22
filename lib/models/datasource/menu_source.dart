import 'package:food_delivery_kandarbite/models/food.dart';

class Menu_Source {
  List<Food> getMenu() {
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
          description: "Air milo, sedap.",
          imagePath: "lib/assets/images/drinks/milo_ais.jpeg",
          price: 3,
          category: FoodCategory.minuman,
          availableAddons: [
            Addon(name: "Ais", price: .5),
            Addon(name: "Mangkuk", price: 1),
          ]),
    ];
    return _menu;
  }
}
