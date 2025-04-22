import 'package:bmi_calculator/screens/bmi_calc_screen.dart';
import 'package:bmi_calculator/screens/car_screen.dart';
import 'package:bmi_calculator/screens/intro_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blueGrey,
          primaryIconTheme: const IconThemeData(color: Colors.white),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
            floatingLabelStyle: TextStyle(color: Colors.blueGrey, fontSize: 16),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.blueGrey,
              width: 2.5,
            )),
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.grey,
              width: 2.5,
            )),
          ),
          textSelectionTheme: const TextSelectionThemeData(
            selectionHandleColor: Colors.blueGrey,
            cursorColor: Colors.blueGrey,
          ),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.blueGrey,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
          )),
          toggleButtonsTheme:
              const ToggleButtonsThemeData(selectedColor: Colors.blueGrey),
          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(backgroundColor: Colors.blueGrey)),
      routes: {
        '/': (context) => const IntroScreen(),
        '/bmi': (context) => const BMICalcScreen()
      },
      initialRoute: '/',
    );
  }
}
