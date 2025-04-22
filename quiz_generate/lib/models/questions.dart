class Questions {
  const Questions(this.text, this.answer);

  final String text;
  final List<String> answer;

  List<String> getShuffledAnswers() {
    final shuffledAnswersList = List.of(answer);
        shuffledAnswersList.shuffle();
    return shuffledAnswersList;
  }


}