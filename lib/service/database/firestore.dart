import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_kandarbite/models/cart_item.dart';

class FirestoreService {
  //get colelction of order
  final CollectionReference orders =
      FirebaseFirestore.instance.collection("orders");
  // save order to db
  Future<void> saveOrderToDB(
      String receipt, String username, List<CartItem> cart) async {
    List<Map<String, dynamic>> cartItemsMap =
        cart.map((item) => item.toMap()).toList();
    await orders.add({
      'date': DateTime.now(),
      'order': receipt,
      'user': username,
      'order_detailed': cartItemsMap,
    });
  }

  Future<List<CartItem>> getOrderFromDBRich(String username) async {
    final DocumentReference orders =
        FirebaseFirestore.instance.collection("orders_record").doc(username);

    DocumentSnapshot docSnapshot = await orders.get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      List<dynamic> cartItemsData = data['cartItems'];

      List<CartItem> cartItems =
          cartItemsData.map((item) => CartItem.fromMap(item)).toList();
      return cartItems;
    } else {
      return [];
    }
  }

  // Save Order Richly
  Future<void> saveOrderToDBRich(List<CartItem> cart, String username) async {
    final DocumentReference orders =
        FirebaseFirestore.instance.collection("orders_record").doc(username);
    List<Map<String, dynamic>> cartItemsMap =
        cart.map((item) => item.toMap()).toList();

    // Wrap the list in a map
    await orders.set({
      'date': DateTime.now().toString(),
      'cartItems': cartItemsMap,
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
    } catch (e) {}
  }
}
