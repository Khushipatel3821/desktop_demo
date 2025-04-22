import 'package:flutter/material.dart';
import 'package:quiz_generate/widgets/questions_summary.dart';

import '../data/questions_data.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.restartQuiz, {super.key, required this.selectedAnswerList});

  final void Function() restartQuiz;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < selectedAnswerList.length; i++) {
      summary.add({
        "question_index": i,
        "questions": questions[i].text,
        "correct_answer": questions[i].answer[0],
        "user_answer": selectedAnswerList[i]
      });
    }

    return summary;
  }

  final List<String> selectedAnswerList;

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data["user_answer"] == data["correct_answer"];
    }).length;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Text("You answered $numCorrectQuestions out of $numTotalQuestions question correctly",
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold )),
                )),
            Expanded(
              flex: 6,
                child: SingleChildScrollView(child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: QuestionsSummary(summaryData: summaryData),
                ))),
            Expanded(
              flex: 1,
              child: TextButton(
                  onPressed: () {
                    restartQuiz();
                  }, child: const Text("Restart Quiz!",style: TextStyle(color: Colors.black, fontSize: 18))),
            )
          ],
        ),
      ),
    );
  }
}
