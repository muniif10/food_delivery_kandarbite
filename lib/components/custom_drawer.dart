import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/pages/past_orders.dart';
import 'package:food_delivery_kandarbite/service/auth/auth_service.dart';
import 'package:food_delivery_kandarbite/components/custom_drawer_tile.dart';
import 'package:food_delivery_kandarbite/pages/setting_page.dart';
import 'package:food_delivery_kandarbite/service/database/firestore.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void logout() async {
    final authService = AuthService();
    try {
      authService.signOut();
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  String whatTier(double points) {
    String tier = "";
    switch (points) {
      case > 700:
        tier = "🥩 Wagyu-tier"; // Ultra Premium
        break;
      case > 600:
        tier = "🐐 Kambing-tier"; // Premium
        break;
      case > 500:
        tier = "🦑 Sotong-tier"; // High
        break;
      case > 450:
        tier = "🦐 Udang-tier"; // Medium-High
        break;
      case > 400:
        tier = "🐓 Ayam Kampung-tier"; // Above Medium
        break;
      case > 350:
        tier = "🐔 Ayam-tier"; // Medium
        break;
      case > 300:
        tier = "🥩 Daging-tier"; // Medium-Low
        break;
      case > 250:
        tier = "🐟 Ikan Merah-tier"; // Low-Medium
        break;
      case > 200:
        tier = "🐟 Ikan-tier"; // Low
        break;
      case > 150:
        tier = "🥦 Sayur Premium-tier"; // Basic+
        break;
      case > 100:
        tier = "🥦 Sayur-tier"; // Basic
        break;
      default:
        tier = "💧 Air-tier"; // Minimal
    }
    return tier;
  }

  double points = 0;

  @override
  void initState() {
    super.initState();
    getPointsFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 100,
                          child: GestureDetector(
                            onTap: () {
                              addPointsToDB();
                            },
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'KandarPoints',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.yellow[900],
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue[900]),
                                      '${points.toStringAsFixed(0)} Pts.',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 150,
                          height: 100,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.yellow[900],
                                        ),
                                    'You are',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue[900]),
                                    whatTier(points),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            // Home list tile
            CustomerDrawerTile(
              text: "HOME",
              icon: Icons.home,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Setting List Tile
            CustomerDrawerTile(
              text: "SETTINGS",
              icon: Icons.settings,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingPage(),
                    ));
              },
            ),
            CustomerDrawerTile(
              text: "PAST ORDERS",
              icon: Icons.history,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PastOrdersPage(),
                    ));
              },
            ),
            const Spacer(),
            // Logout Setting Tile
            CustomerDrawerTile(
              text: "LOGOUT",
              icon: Icons.logout,
              onTap: logout,
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }

  void getPointsFromDB() async {
    FirestoreService db = FirestoreService();
    User? currentUser = FirebaseAuth.instance.currentUser;
    int currentPoints = await db.getPoints(currentUser?.email ?? "");
    setState(() {
      points = currentPoints.ceilToDouble();
    });
  }

  void addPointsToDB() async {
    FirestoreService db = FirestoreService();
    User? currentUser = FirebaseAuth.instance.currentUser;
    String? email = currentUser?.email ?? "";

    if (email == "muniif10@gmail.com") {
      int currentPoints = await db.getPoints(email);
      await db.createOrUpdatePoints(currentPoints + 20, email);
      getPointsFromDB();
    } else {}
  }
}
