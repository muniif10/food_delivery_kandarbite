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

  Future<List<Map<String, String>>> getOrders(String email) async {
    QuerySnapshot ordersObtained =
        await orders.where('email', isEqualTo: email).get();
    List<QueryDocumentSnapshot> docs = ordersObtained.docs;
    return docs.map((doc) => doc.data() as Map<String, String>).toList();
  }
}
