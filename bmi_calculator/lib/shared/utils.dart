import 'package:flutter/material.dart';

class Utils {
  static const String IMG = 'assets/images/img.png';
  static const String IMG1 = 'assets/images/img_1.png';

  static Widget buildHeroIcon(String path, String tag) {
    return Hero(
        tag: tag,
        child: Container(
            width: 80,
            height: 80,
            child: Image.asset(
              path,
              fit: BoxFit.cover,
            )));
  }

  static Widget buildHeroDestination(String path, String tag, double width) {
    return Hero(
        tag: tag,
        child: Container(
            width: width,
            child: Image.asset(
              path,
              fit: BoxFit.cover,
            )));
  }
}
