import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/auth/login_or_register.dart';
import 'package:food_delivery_kandarbite/components/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF002358),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 35),

            // Restaurant Name
            Text(
              "KandarBite",
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0xFFDBD480),
              ),
            ),

            // Image without padding
            Image.asset(
              'lib/assets/images/logo.png',
              width: 350,
              height: 350,
              fit: BoxFit.cover,
            ),

            // Subtitle
            Text(
              "KandarBite offers you the greatest Mamak food by fusing convenience with tradition. With KandarBite, experience the true taste of Malaysia.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFDBD480),
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 50),

            // Get Started Button
            CustomButton(
              text: "Get Started",
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("isFirstTime", false);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoginOrRegister(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: IntroPage(),
  ));
}
