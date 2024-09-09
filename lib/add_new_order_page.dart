import 'package:flutter/material.dart';
import 'package:practicaltest/order_service.dart';
import 'package:practicaltest/order.dart';
import 'package:firebase_database/firebase_database.dart';

class AddNewOrderPage extends StatelessWidget {
  final OrderService _orderService = OrderService(FirebaseDatabase.instance);

  final _formKey = GlobalKey<FormState>();
  String _dishName = '';
  int _votes = 0;
  int _quantity = 1;

  void _addOrder(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newOrder = Order(dishName: _dishName, votes: _votes, quantity: _quantity);
      await _orderService.addOrder(newOrder);
      Navigator.pop(context); // Quay lại trang danh sách đơn hàng
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Dish name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a dish name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _dishName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Votes',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _votes = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Quantity',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _quantity = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Add Order'),
                onPressed: () => _addOrder(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
