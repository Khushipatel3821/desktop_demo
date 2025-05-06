import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Details",
          style: TextStyle(
              fontSize: 25, color: Colors.amber, backgroundColor: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ElevatedButton(
        onPressed: () => context.go("/"),
        child: Text("Go back to home screen."),
      ),
    );
  }
}
