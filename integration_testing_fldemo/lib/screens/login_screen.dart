import 'package:flutter/material.dart';
import 'package:integration_testing_fldemo/auth_service.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    authInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LOGIN",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                key: Key("username_controller"),
                controller: _usernameController,
                cursorColor: Colors.black45,
                decoration: InputDecoration(
                  label: Text("Username"),
                  focusColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  label: Text("Password"),
                  focusColor: Colors.black,
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  _validLogin();
                },
                clipBehavior: Clip.hardEdge,
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              IconButton(
                  onPressed: () {
                    authInit();
                  },
                  icon: Icon(
                    Icons.fingerprint,
                    size: 50,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _validLogin() {
    if (_usernameController.text == "username" &&
        _passwordController.text == "password") {
      navigateToHomeScreen();
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Invalid username or password"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void authInit() async {
    bool checkAuth = await AuthService().authenticateLocally(context);
    if (checkAuth) {
      navigateToHomeScreen();
    }
  }

  void navigateToHomeScreen() {
    // pushReplacement --> not come back ideal for login screen
    // push --> we can navigate to back
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => HomeScreen(),
      ),
    );
  }
}
