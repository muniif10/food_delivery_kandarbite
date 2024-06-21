import 'package:flutter/material.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  void openLocationSearchBox(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        actions: [
          MaterialButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Submit"),
          )
        ],
        title: const Text("Your location"),
        content: const TextField(
          decoration: InputDecoration(hintText: "Search address..."),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver now",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                // Address
                Flexible(
                  child: Text(
                    "Menara LGB, Level 16, 1, Jalan Wan Kadir, Taman Tun Dr Ismail, 60000 Kuala Lumpur",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),

                // Dropdown
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          )
        ],
      ),
    );
  }
}
