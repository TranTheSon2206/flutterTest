import 'package:flutter/material.dart';
import 'package:practicaltest/drawer_page.dart'; // Import DrawerPage

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Head Chef'),
      ),
      drawer: DrawerPage(), // Thêm drawer vào HomePage
      body: Center(
        child: Text('Home Page', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
