class Food {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final FoodCategory category;
  List<Addon> availableAddons;

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'price': price,
      'category': category.toString(),
      'availableAddons': availableAddons.map((addon) => addon.toMap()).toList(),
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      name: map['name'],
      description: map['description'],
      imagePath: map['imagePath'],
      price: map['price'],
      category: FoodCategoryExtension.fromString(map['category']),
      availableAddons: List<Addon>.from(map['availableAddons'].map((addon) => Addon.fromMap(addon))),
    );
  }
}

class Addon {
  String name;
  double price;

  Addon({
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }

  factory Addon.fromMap(Map<String, dynamic> map) {
    return Addon(
      name: map['name'],
      price: map['price'],
    );
  }
}

enum FoodCategory {
  nasi,
  minuman,
  roti,
}

extension FoodCategoryExtension on FoodCategory {
  static FoodCategory fromString(String category) {
    return FoodCategory.values.firstWhere((e) => e.toString() == category);
  }
}
