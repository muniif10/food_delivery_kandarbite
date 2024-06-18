import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/components/current_location.dart';
import 'package:food_delivery_kandarbite/components/custom_description_box.dart';
import 'package:food_delivery_kandarbite/components/custom_drawer.dart';
import 'package:food_delivery_kandarbite/components/custom_sliver_app_bar.dart';
import 'package:food_delivery_kandarbite/components/custom_tab.dart';
import 'package:food_delivery_kandarbite/components/food_tile.dart';
import 'package:food_delivery_kandarbite/models/food.dart';
import 'package:food_delivery_kandarbite/models/restaurant.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late TabController _tabController;

  // Sort out and return list of food
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  // return list of food given the category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);
      return ListView.builder(
        itemBuilder: (context, index) {
          final food = categoryMenu[index];
          return FoodTile(onTap: () {}, food: food);
        },
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomSliverAppBar(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Current Location
                CurrentLocation(),
                // Description Box
                CustomDescriptionBox(),
              ],
            ),
            title: CustomTab(tabController: _tabController),
          )
        ],
        body: Consumer<Restaurant>(
          builder: (BuildContext context, Restaurant fullMenu, Widget? child) {
            return TabBarView(
                controller: _tabController,
                children: getFoodInThisCategory(fullMenu.menu));
          },
        ),
      ),
    );
  }
}
