import 'package:flutter/material.dart';

class AddDataProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _mData = [];
  //event
  void addData(Map<String, dynamic> data) {
    _mData.add(data);
    notifyListeners();
  }
}