import 'package:api_integration_fl/network/api_services.dart';
import 'package:flutter/material.dart';

import '../network/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<UserModel>? _userModel = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("REST API DEMO"),),
      body: _userModel == null || _userModel!.isEmpty ? const Center(
        child: CircularProgressIndicator(),) : ListView.builder(itemCount: _userModel!.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Text(_userModel![index].id.toString()),
                title: Text(_userModel![index].username),
                subtitle: Text(_userModel![index].email),
                trailing: Text(_userModel![index].website),
              ),
            );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = await ApiService().getUsers();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }
}
