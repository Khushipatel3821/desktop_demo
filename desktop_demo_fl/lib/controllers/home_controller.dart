import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  String yourText = "";

  void updateText(String newText) {
    yourText = newText;
    notifyListeners();
  }
}
