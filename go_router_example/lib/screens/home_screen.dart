import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        "Home Screen",
          style: TextStyle(
              fontSize: 25, color: Colors.amber, backgroundColor: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ElevatedButton(
        onPressed: () => context.go("/details"),
        child: Text("Go to details screen."),
      ),
    );

  }

}