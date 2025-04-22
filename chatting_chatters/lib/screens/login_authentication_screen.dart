import 'dart:io';

import 'package:chatting_chatters/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebaseAuth = FirebaseAuth.instance;

class LoginAuthenticationScreen extends StatefulWidget {
  const LoginAuthenticationScreen({super.key});

  @override
  State<LoginAuthenticationScreen> createState() =>
      _LoginAuthenticationScreenState();
}

class _LoginAuthenticationScreenState extends State<LoginAuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = "";
  var _enteredPassword = "";
  var _enteredUsername = "";
  File? _selectedImage;
  var _isAuthenticate = false;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid || (!_isLogin && _selectedImage == null)) {
      // show error message...
      return;
    }

    _formKey.currentState!.save();

    try {
      setState(() {
        _isAuthenticate = true;
      });
      if (_isLogin) {
        // user log in
        final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
        print(userCredentials);
      } else {
        // user sign up
        final userCredentials =
            await _firebaseAuth.createUserWithEmailAndPassword(
                email: _enteredEmail, password: _enteredPassword);
        print(userCredentials);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child("user_images")
            .child("${userCredentials.user!.uid}.jpg");

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        print(imageUrl);

        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredentials.user!.uid)
            .set({
          "username": _enteredUsername,
          "email": _enteredEmail,
          "userImage": imageUrl
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "email-already-in-use") {
        // specific error code wise error handle
      }
      var errorMessage = "Authentication failed";
      if (error.message != null) {
        errorMessage = error.message!;
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
      setState(() {
        _isLogin = false;
        _isAuthenticate = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 30, left: 20, bottom: 20, right: 20),
                width: 200,
                child: Image.asset("assets/images/chat.png"),
              ),
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!_isLogin)
                              UserImagePicker(
                                onPickImage: (pickImage) {
                                  _selectedImage = pickImage;
                                },
                              ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Email Address",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains("@")) {
                                  return "Please enter a valid email address.";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Username",
                              ),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return "Please enter at least 4 characters of username.";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredUsername = value!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Password",
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return "Password must be at least 6 character long.";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPassword = value!;
                              },
                            ),
                            if (_isAuthenticate)
                              const CircularProgressIndicator(),
                            if (!_isAuthenticate)
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _submit();
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                  child: Text(_isLogin ? "Login" : "Sign Up"),
                                ),
                              ),
                            if (!_isAuthenticate)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: Text(_isLogin
                                    ? "Create an Account"
                                    : "I Already have an Account"),
                              )
                          ],
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
