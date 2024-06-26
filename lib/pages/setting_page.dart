import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  final SnackBar snackbar =
      const SnackBar(content: Text("This setting does nothing, sorry.",style: TextStyle(color: Colors.black),));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(
              left: 25,
              top: 10,
              right: 25,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Dark Mode"),
                Switch(
                    value: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode,
                    onChanged: (value) =>
                        {ScaffoldMessenger.of(context).showSnackBar(snackbar)})
              ],
            ),
          )
        ],
      ),
    );
  }
}
