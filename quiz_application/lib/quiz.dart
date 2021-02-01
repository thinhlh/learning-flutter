import 'package:flutter/material.dart';

import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final Function answerQuestion;
  final List<Map<String, Object>> questions;
  final int questionIndex;
  Quiz({
    @required this.answerQuestion,
    @required this.questions,
    @required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex]['question'],
        ),
        ...(questions[questionIndex]['answer'] as List<Map<String,Object>>).map((answer) {
          return Answer(()=>answerQuestion(answer['isTrue']), answer['text']);
        }).toList()
        /*
          * using .map(function) to return a List of Answer that was construct from a List of String
          * Then we use as List<String> to notify the input before using .map
          * After that, we use .toList() to turn a map to a List
          * Above code will mapping a List to a List of widgets
          * however this will return a nested list which mean a list in a list
          * So that we have to use ... as a spread operator that take a list and pull all the VALUE in the list out of it and add them to the surrounding
          * list as individuals values
        */
      ],
    );
  }
}
