import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:practicaltest/order_service.dart';
import 'package:practicaltest/order.dart';
import 'package:practicaltest/add_new_order_page.dart'; // Thêm import cho trang thêm đơn hàng

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final OrderService _orderService = OrderService(FirebaseDatabase.instance);
  Map<String, Order> _ordersWithKey = {}; // Lưu trữ key của mỗi đơn hàng
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final ordersWithKey = await _orderService.getOrders();
    setState(() {
      _ordersWithKey = ordersWithKey;
      _loading = false;
    });
  }

  Future<void> _addOrder() async {
    // Điều hướng đến trang thêm đơn hàng
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewOrderPage()),
    );
    _fetchOrders(); // Cập nhật danh sách sau khi thêm đơn hàng mới
  }

  Future<void> _deleteOrder(String key) async {
    await _orderService.deleteOrder(key);
    _fetchOrders(); // Cập nhật danh sách sau khi xóa đơn hàng
  }

  Widget _buildOrderItem(String key, Order order) {
    return ListTile(
      title: Text(order.dishName ?? 'Unknown'),
      subtitle: Text('Votes: ${order.votes} - Quantity: ${order.quantity}'),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          _deleteOrder(key); // Xóa đơn hàng theo key
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addOrder, // Điều hướng đến trang thêm đơn hàng khi nhấn
          ),
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _ordersWithKey.length,
        itemBuilder: (context, index) {
          final orderKey = _ordersWithKey.keys.elementAt(index); // Lấy key của đơn hàng
          final order = _ordersWithKey[orderKey]!;
          return _buildOrderItem(orderKey, order);
        },
      ),
    );
  }
}
