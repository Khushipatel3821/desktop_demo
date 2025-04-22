import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: summaryData.map(
        (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(100, 255, 144, 144),
                        child: Text(((data["question_index"] as int) + 1).toString(), style: const TextStyle(color: Colors.white, fontSize: 18) ))),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(data["questions"] as String, style: const TextStyle(color: Colors.white, fontSize: 18) ,),
                      Text(data["user_answer"] as String, style: const TextStyle(color: Colors.yellow, fontSize: 18) ),
                      Text(data["correct_answer"] as String, style: const TextStyle(color: Colors.green, fontSize: 18) )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
