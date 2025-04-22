import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Screen",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "This is Home Screen.",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
    );
  }
}
