import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/components/custom_button.dart';
import 'package:food_delivery_kandarbite/components/custom_textfield.dart';
import 'package:food_delivery_kandarbite/service/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function() onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  void login() async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(email.text, password.text);
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
    // Navigator.of(context).push(MaterialPageRoute(
    // builder: (context) => HomePage(),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_open_rounded,
              size: 72,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "KandarBite App",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
            const SizedBox(
              height: 25,
            ),
            // Email
            CustomTextfield(
              controller: email,
              hintText: "Email",
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            // Password
            CustomTextfield(
                controller: password, hintText: "Password", obscureText: true),
            const SizedBox(
              height: 25,
            ),
            // Sign In
            CustomButton(
              onTap: login,
              text: "Sign In",
            ),

            const SizedBox(
              height: 25,
            ),
            // Divider
            Divider(
              color: Theme.of(context).colorScheme.inversePrimary,
              endIndent: 50,
              indent: 50,
            ),
            const SizedBox(
              height: 25,
            ),
            // Not a member?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Register Now",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
