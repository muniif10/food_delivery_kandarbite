import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/models/food.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.tabController,
  });
  final TabController tabController;

  List<Tab> _buildCategoryTab() {
    return FoodCategory.values.map((category) {
      return Tab(
        text: category.toString().split('.').last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).colorScheme.surface,
      child: TabBar(
        tabs: _buildCategoryTab(),
        controller: tabController,
      ),
    );
  }
}
