import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/auth/login_or_register.dart';
import 'package:food_delivery_kandarbite/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: LoginOrRegister(),
        ),
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
