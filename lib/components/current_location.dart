import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  void setLocation(String newLocation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("locationString", newLocation);
    setState(() {
      location = newLocation;
    });
  }

  void loadString() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String locationOrNot = prefs.getString("locationString") ?? location;
    setState(() {
      location = locationOrNot;
    });
  }

  @override
  void initState() {
    super.initState();
    loadString();
  }

  String location =
      "Menara LGB, Level 16, 1, Jalan Wan Kadir, Taman Tun Dr Ismail, 60000 Kuala Lumpur";
  void openLocationSearchBox(BuildContext ctx) {
    TextEditingController addressController = TextEditingController();
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
              setLocation(addressController.text);
            },
            child: const Text("Submit"),
          )
        ],
        title: const Text("Your location"),
        content: TextField(
          controller: addressController,
          decoration: const InputDecoration(hintText: "Search address..."),
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
                    location,
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
