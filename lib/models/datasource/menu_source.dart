import 'package:food_delivery_kandarbite/models/food.dart';

class MenuSource {
  List<Food> getMenu() {
    final List<Food> menu = [
      // nasi
  Food(
  name: "Nasi Kandar Padu",
  description: "Well-cooked rice with juicy fried chicken, served with a variety of tasty and aromatic 'kuah'.",
  imagePath: "lib/assets/images/nasi/nasi_kandar_biasa.jpg",
  price: 7,
  category: FoodCategory.rice,
  availableAddons: [
    Addon(name: "Extra Chicken", price: 5),
    Addon(name: "Sayur", price: 1),
    Addon(name: "Papadom", price: 1),
  ],
),
Food(
  name: "Nasi Briyani",
  description: "Well-cooked rice paired with juicy fried chicken, infused with aromatic spices.",
  imagePath: "lib/assets/images/nasi/nasi_briyani.jpg",
  price: 9,
  category: FoodCategory.rice,
  availableAddons: [
    Addon(name: "Extra Chicken", price: 5),
    Addon(name: "Sayur", price: 1),
    Addon(name: "Papadom", price: 1),
  ],
),
Food(
  name: "Nasi Kabsah",
  description: "Well-cooked rice with juicy fried chicken, seasoned with Middle Eastern spices.",
  imagePath: "lib/assets/images/nasi/nasi_kabsa_ayam.jpg",
  price: 11,
  category: FoodCategory.rice,
  availableAddons: [
    Addon(name: "Extra Chicken", price: 5),
    Addon(name: "Sayur", price: 1),
    Addon(name: "Papadom", price: 1),
  ],
),
      Food(
          name: "Milo",
          description:
              "A chocolate malt drink made from milk, cocoa, barley malt, sugar.",
          imagePath: "lib/assets/images/drinks/milo.jpg",
          price: 3,
          category: FoodCategory.drinks,
          availableAddons: [
            Addon(name: "Ice Cream", price: 1),
            Addon(name: "Extra Milo", price: 1),
            Addon(name: "Ice", price: 1),
          ]),
      Food(
          name: "Sirap Bandung",
          description: "Refreshing rose syrup mixed with condensed milk.",
          imagePath: "lib/assets/images/drinks/sirap bandung.jpeg",
          price: 3,
          category: FoodCategory.drinks,
          availableAddons: [
            Addon(name: "Grass Jelly", price: 1),
            Addon(name: "Soda", price: 1.5),
            Addon(name: "Ice", price: 1),
          ]),
      Food(
          name: "Teh Tarik",
          description: "A traditional pulled tea with milk, frothy and sweet.",
          imagePath: "lib/assets/images/drinks/Teh tarik.jpg",
          price: 2.2,
          category: FoodCategory.drinks,
          availableAddons: [
            Addon(name: "Ginger", price: 1),
            Addon(name: "Ice", price: 1),
          ]),
          Food(
          name: "Roti Canai",
          description: " crispy and fluffy flatbread served with dhal curry and sambal.",
          imagePath: "lib/assets/images/roti/roti canai.jpg",
          price: 1.2,
          category: FoodCategory.breads,
          availableAddons: [
            Addon(name: "Chicken Curry", price: 2),
            Addon(name: "Lamb Curry", price: 3),
            Addon(name: "Condensed Milk", price: .5),
          ]),
          Food(
          name: "Roti Telur",
          description: " crispy and fluffy flatbread served with dhal curry and sambal.",
          imagePath: "lib/assets/images/roti/roti telur.jpg",
          price: 2.3,
          category: FoodCategory.breads,
          availableAddons: [
            Addon(name: "Chicken Curry", price: 2),
            Addon(name: "Lamb Curry", price: 3),
            Addon(name: "Condensed Milk", price: .5),
          ]),
          Food(
          name: "Roti Tisu",
          description: "A thin, crispy flatbread topped with sweet condensed milk and sugar",
          imagePath: "lib/assets/images/roti/roti tisu.jpg",
          price: 3.5,
          category: FoodCategory.breads,
          availableAddons: [
            Addon(name: "Chocolate sauce", price: 2),
            Addon(name: "Chocolate rice", price: 3),
          ]),
    ];
    return menu;
  }
}
