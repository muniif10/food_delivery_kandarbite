import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.tabController,
  });
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: const [
        // 1st tab
        Tab(
          icon: Icon(Icons.home),
        ),
        // 2nd Tab
        Tab(
          icon: Icon(Icons.settings),
        ),
        Tab(
          icon: Icon(Icons.person),
        ),
      ],
      controller: tabController,
    );
  }
}
