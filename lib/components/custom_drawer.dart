import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/pages/past_orders.dart';
import 'package:food_delivery_kandarbite/service/auth/auth_service.dart';
import 'package:food_delivery_kandarbite/service/auth/login_or_register.dart';
import 'package:food_delivery_kandarbite/components/custom_drawer_tile.dart';
import 'package:food_delivery_kandarbite/pages/setting_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void logout() async {
    final _authService = AuthService();
    try {
      _authService.signOut();
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
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
              child: Icon(
                Icons.lock_open_rounded,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
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
                      builder: (context) => SettingPage(),
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
                      builder: (context) => PastOrdersPage(),
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
}
