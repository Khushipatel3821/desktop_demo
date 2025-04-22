import 'package:flutter/material.dart';
import 'package:quiz_generate/screens/questions_screen.dart';
import 'package:quiz_generate/screens/result_screen.dart';
import 'package:quiz_generate/screens/start_screen.dart';

import 'data/questions_data.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  Widget? activeScreen;
  List<String> selectedAnswer = [];

  void choosenAnswer(String answer) {
    selectedAnswer.add(answer);

    setState(() {
      if(selectedAnswer.length == questions.length) {
        activeScreen = ResultScreen(switchScreen, selectedAnswerList: selectedAnswer);
      }
    });

  }

  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    selectedAnswer = [];

    setState(() {
      activeScreen = QuestionsScreen(onSelectedAnswer: choosenAnswer,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 64, 13, 152),
                Color.fromARGB(255, 120, 2, 56),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: activeScreen),
      ),
    );
  }
}
