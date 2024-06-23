import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/service/auth/auth_gate.dart';
import 'package:food_delivery_kandarbite/firebase_options.dart';
import 'package:food_delivery_kandarbite/models/restaurant.dart';
import 'package:food_delivery_kandarbite/pages/intro_page.dart';
import 'package:food_delivery_kandarbite/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
          child: isFirstTime ? const IntroPage() : const AuthGate(),
        ),
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
