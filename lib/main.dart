import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practicaltest/firebase_options.dart';
import 'package:practicaltest/order_list_page.dart';
import 'package:practicaltest/home_page.dart'; // Import trang HomePage
import 'package:practicaltest/drawer_page.dart'; // Import trang DrawerPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Head Chef',
      theme: ThemeData(
        primarySwatch: Colors.green, // Phông màu chủ đạo xanh lá đậm
        primaryColor: Colors.green[800], // Sử dụng màu xanh lá đậm hơn
        scaffoldBackgroundColor: Colors.green[50], // Màu nền nhẹ nhàng hơn
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[800], // Màu nền của AppBar
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700], // Màu của nút bấm
          ),
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/orders': (context) => OrderListPage(),
        '/restaurants': (context) => Scaffold(
          appBar: AppBar(title: Text('Restaurants')),
          drawer: DrawerPage(),
          body: Center(child: Text('Restaurants Page')),
        ),
        '/settings': (context) => Scaffold(
          appBar: AppBar(title: Text('Settings')),
          drawer: DrawerPage(),
          body: Center(child: Text('Settings Page')),
        ),
        '/about': (context) => Scaffold(
          appBar: AppBar(title: Text('About Me')),
          drawer: DrawerPage(),
          body: Center(child: Text('About Me Page')),
        ),
      },
    );
  }
}
