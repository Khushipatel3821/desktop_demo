import 'package:ble_scan_connect_fl/screens/ble_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //BLE - Bluetooth Low Energy
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Low Energy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BleScreen(),
    );
  }
}
