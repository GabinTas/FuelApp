import 'package:flutter/material.dart';
import 'screens/home_screen.dart';


void main() {
  runApp(const MyFuel());
}

class MyFuel extends StatelessWidget {
  const MyFuel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fuel_price_app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyFuelApp(title: 'Prix Carburants'),
    );
  }
}


