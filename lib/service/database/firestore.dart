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

  Future<int> getPoints(String username) async {
    final DocumentReference points =
        FirebaseFirestore.instance.collection("userData").doc(username);

    try {
      final DocumentSnapshot currentPoints =
          await points.get(const GetOptions(source: Source.server));
      if (currentPoints.exists) {
        var data = currentPoints.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey("points")) {
          return data["points"] as int;
        }
      }
      return 0; // Return 0 if document does not exist or if points field is missing
    } catch (e) {
      return -1; // Return -1 in case of an error
    }
  }

  Future<void> createOrUpdatePoints(int point, String username) async {
    final DocumentReference points =
        FirebaseFirestore.instance.collection("userData").doc(username);

    try {
      final DocumentSnapshot docSnapshot = await points.get();
      if (docSnapshot.exists) {
        await points.update({'points': point});
      } else {
        await points.set({'points': point});
      }
    // ignore: empty_catches
    } catch (e) {
    }
  }


  
}
