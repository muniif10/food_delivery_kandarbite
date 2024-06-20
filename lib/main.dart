import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/auth/login_or_register.dart';
import 'package:food_delivery_kandarbite/models/restaurant.dart';
import 'package:food_delivery_kandarbite/pages/intro_page.dart';
import 'package:food_delivery_kandarbite/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => Restaurant(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isFirstTime = false;

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isFirstTimeOrNull = prefs.getBool("isFirstTime");
    setState(() {
      if (isFirstTimeOrNull != null) {
        isFirstTime = isFirstTimeOrNull;
      } else {
        isFirstTime = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: isFirstTime ? IntroPage() : LoginOrRegister(),
        ),
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
