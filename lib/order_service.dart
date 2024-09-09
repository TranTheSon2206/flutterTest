import 'package:firebase_database/firebase_database.dart';
import 'package:practicaltest/order.dart';

class OrderService {
  final FirebaseDatabase _database;

  OrderService(this._database);

  Future<void> addOrder(Order order) async {
    await _database.reference().child('orders').push().set(order.toJson());
  }

  Future<Map<String, Order>> getOrders() async {
    final snapshot = await _database.reference().child('orders').get();
    if (snapshot.exists && snapshot.value != null) {
      final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
      final ordersWithKey = <String, Order>{};
      data.forEach((key, value) {
        ordersWithKey[key] = Order.fromJson(Map<String, dynamic>.from(value));
      });
      return ordersWithKey;
    } else {
      return {};
    }
  }

  Future<void> updateOrder(String key, Order order) async {
    await _database.reference().child('orders/$key').update(order.toJson());
  }

  Future<void> deleteOrder(String key) async {
    await _database.reference().child('orders/$key').remove();
  }
}
