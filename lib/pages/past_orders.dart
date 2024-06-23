import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_kandarbite/components/past_order_tile.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Past Orders",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          centerTitle: true,
        ),
        body: pastOrders.isEmpty? const Center(child: Text("No past orders.")) : ListView.builder(
          itemBuilder: (context, index) {
            Map<String, dynamic> receipt = pastOrders[index];
            final Timestamp timestamp = receipt['date'] as Timestamp;
            final DateTime dateTime = timestamp.toDate();
            final dateString = DateFormat('E h:mm a  d/M/y').format(dateTime);
            return PastOrderTile(dateString: dateString, receipt: receipt);
          },
          itemCount: pastOrders.length,
          padding: const EdgeInsets.all(25),
        ));
  }
}
