import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get colelction of order
  final CollectionReference orders =
      FirebaseFirestore.instance.collection("orders");
  // save order to db
  Future<void> saveOrderToDB(String receipt, String username) async {
    await orders.add({
      'date': DateTime.now(),
      'order': receipt,
      'user': username,
    });
  }
}
