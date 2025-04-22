import 'package:bmi_calculator/data/intro.dart';
import 'package:bmi_calculator/shared/menu_bottom.dart';
import 'package:bmi_calculator/shared/menu_drawer.dart';
import 'package:bmi_calculator/shared/utils.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Globo Fitness')),
      drawer: const MenuDrawer(),
      bottomNavigationBar: const MenuBottom(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                    onTap: () {
                      changeRoute(context, 'img');
                    },
                    child: Utils.buildHeroIcon(Utils.IMG, 'img'))),
            Expanded(
                flex: 1,
                child: GestureDetector(
                    onTap: () {
                      changeRoute(context, 'img1');
                    },
                    child: Utils.buildHeroIcon(Utils.IMG1, 'img1'))),
          ],
        ),
      ),
    );
  }

  void changeRoute(BuildContext context, String fitness) {
    switch (fitness) {
      case 'img':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IntroDetails(Utils.IMG, fitness)));
        break;
      case 'img1':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IntroDetails(Utils.IMG1, fitness)));
        break;
      default:
    }
  }
}
