import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/components/custom_button.dart';
import 'package:food_delivery_kandarbite/components/custom_textfield.dart';
import 'package:food_delivery_kandarbite/service/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function() onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  void register() async {
    // Get auth
    final authService = AuthService();

    // Check if password match
    if (password.text == confirmPassword.text) {
      try {
        await authService.signUpWithEmailPassword(email.text, password.text);
        // Navigator.of(context).pop();
      } catch (e) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords does not match!"),
        ),
      );
    }
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
              Icons.app_registration,
              size: 72,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Let's create an account",
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
              height: 10,
            ),
            CustomTextfield(
                controller: confirmPassword,
                hintText: "Confirm Password",
                obscureText: true),
            const SizedBox(
              height: 25,
            ),
            // Sign In
            CustomButton(
                onTap: () {
                  register();
                },
                text: "Sign Up"),

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
                  "Already have an account?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Login now",
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
