import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/components/past_order_tile.dart';
import 'package:food_delivery_kandarbite/models/cart_item.dart';
import 'package:intl/intl.dart';

class PastOrdersPage extends StatefulWidget {
  const PastOrdersPage({super.key});

  @override
  State<PastOrdersPage> createState() => _PastOrdersPageState();
}

class _PastOrdersPageState extends State<PastOrdersPage> {
  List<Map<String, dynamic>> pastOrders = [];

  @override
  void initState() {
    super.initState();
    getPastOrders();
  }

  Future<void> getPastOrders() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final CollectionReference orders =
        FirebaseFirestore.instance.collection("orders");
    QuerySnapshot ordersObtained = await orders
        .where('user', isEqualTo: currentUser?.email ?? "")
        .limit(5)
        .get();
    List<QueryDocumentSnapshot> docs = ordersObtained.docs;
    var result = docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    setState(() {
      pastOrders = result;
    });
  }

  void clearAllPastOrder() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final CollectionReference orders =
        FirebaseFirestore.instance.collection("orders");

    if (currentUser != null && currentUser.email != null) {
      orders
          .where('user', isEqualTo: currentUser.email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      }).catchError((error) {
        print("Failed to delete orders: $error");
      });
    } else {
      print("No user logged in or user email is null.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  clearAllPastOrder();
                  getPastOrders();
                },
                icon: Icon(Icons.delete))
          ],
          title: Text(
            "Past Orders",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          centerTitle: true,
        ),
        body: pastOrders.isEmpty
            ? const Center(child: Text("No past orders."))
            : ListView.builder(
                itemBuilder: (context, index) {
                  Map<String, dynamic> receipt = pastOrders[index];
                  final Timestamp timestamp = receipt['date'] as Timestamp;
                  final DateTime dateTime = timestamp.toDate();
                  final dateString =
                      DateFormat('E h:mm a  d/M/y').format(dateTime);
                  // CartItem.fromMap(pastOrders[index]['order_detailed']);
                  // List<CartItem> foodDetail =
                  // print(CartItem.fromMap(pastOrders[index]['order_detailed'][0]));
                  List<dynamic> orderDetailed =
                      pastOrders[index]['order_detailed'];
                  List<CartItem> cartDetails = orderDetailed.map((item) {
                    return CartItem.fromMap(item);
                  }).toList();
                  print(cartDetails.length);
                  print(pastOrders[index]['order_detailed']);
                  // List<dynamic> cartDetails =
                  //     pastOrders[index]['order_detailed'];
                  return PastOrderTile(
                    dateString: dateString,
                    receipt: receipt,
                    cartDetail: cartDetails,
                  );
                },
                itemCount: pastOrders.length,
                padding: const EdgeInsets.all(25),
              ));
  }
}
