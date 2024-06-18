import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/components/current_location.dart';
import 'package:food_delivery_kandarbite/components/custom_description_box.dart';
import 'package:food_delivery_kandarbite/components/custom_drawer.dart';
import 'package:food_delivery_kandarbite/components/custom_sliver_app_bar.dart';
import 'package:food_delivery_kandarbite/components/custom_tab.dart';

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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late TabController _tabController;

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
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                // Current Location
                CurrentLocation(),
                // Description Box
                CustomDescriptionBox(),
              ],
            ),
            title: CustomTab(tabController: _tabController),
          )
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Text("Hello"),
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Text("Hello"),
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Text("Hello"),
            ),
          ],
        ),
      ),
    );
  }
}
