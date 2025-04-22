import 'package:bmi_calculator/screens/bmi_calc_screen.dart';
import 'package:bmi_calculator/screens/intro_screen.dart';
import 'package:bmi_calculator/screens/session_screen.dart';
import 'package:bmi_calculator/screens/weather_screen.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = ['Home', 'BMI Calculator', 'Weather', 'Training'];
    List<Widget> menuItems = [];
    menuItems.add(const DrawerHeader(
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: Text('Globo Fitness', style: TextStyle(color: Colors.white, fontSize: 28),),
    ));
    for (var element in menuTitles) {
      Widget screen = Container();
      menuItems.add(ListTile(
        title: Text(element, style: const TextStyle(fontSize: 18),),
        onTap: () {
          switch(element) {
            case 'Home':
              screen = const IntroScreen();
              break;
            case 'BMI Calculator':
              screen = const BMICalcScreen();
              break;
            case 'Weather':
              screen = const WeatherScreen();
              break;
            case 'Training' :
              screen = const SessionScreen();
              break;
          }
          Navigator.of(context).pop();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => screen));
        },
      ));
    }
    return menuItems;
  }
}
