import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/components/receipt.dart';
import 'package:food_delivery_kandarbite/models/restaurant.dart';
import 'package:food_delivery_kandarbite/pages/home_page.dart';
import 'package:food_delivery_kandarbite/service/database/firestore.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  FirestoreService db = FirestoreService();
  User? currentUser = FirebaseAuth.instance.currentUser;
  int userCurrentPoints = 0;

  int gainedPoints = 0;

  @override
  void initState() {
    super.initState();
    String receipt = context.read<Restaurant>().displayCartReceipt();
    db.saveOrderToDB(receipt, currentUser!.email ?? "Not attached to a user.");
    getPointsFromDB();
    setState(() {
      gainedPoints = (context.read<Restaurant>().getTotalPrice() * 0.2).toInt();
    });
    addPointsToDB(gainedPoints);
  }

  void getPointsFromDB() async {
    FirestoreService db = FirestoreService();
    User? currentUser = FirebaseAuth.instance.currentUser;
    int currentPoints = await db.getPoints(currentUser?.email ?? "");
    setState(() {
      userCurrentPoints = currentPoints;
    });
  }

  void addPointsToDB(int pointToAdd) async {
    FirestoreService db = FirestoreService();
    User? currentUser = FirebaseAuth.instance.currentUser;
    int currentPoints = await db.getPoints(currentUser?.email ?? "");
    await db.createOrUpdatePoints(
        currentPoints + pointToAdd, currentUser?.email ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: _buildNavigationBar(context),
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(.8),
        appBar: AppBar(
          leading: const SizedBox(),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<Restaurant>().clearCart();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
                },
                icon: const Icon(
                  Icons.close,
                ))
          ],
          title: const Text("Delivery in progress"),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Receipt(),
              Text("You gained $gainedPoints points from your order."),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      height: 120,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          // Driver detail
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Muadz Khalid",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Driver - Bike",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Message button
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
