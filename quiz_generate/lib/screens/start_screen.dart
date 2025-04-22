import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.switchScreen, {super.key});

  final void Function() switchScreen;
  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/quiz-logo.png",
            width: 200,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 28.0),
            child: Text(
              "Learn Flutter the Fun Way!",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:  8.0),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.transparent),
                onPressed: () {
                  switchScreen();
                }, child: const Text("Start Quiz")),
          )
        ],
      ),
    );
  }
}
