import 'package:first_app/result.dart';
import 'package:flutter/material.dart';

import './quiz.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  var _score=0;
  final _questions = const [
    {
      'question': 'What\'s your favorite song?',
      'answer': [
        {
          'text': 'One more time one more chance',
          'isTrue': true,
        },
        {
          'text': 'Funny Little World',
          'isTrue': false,
        },
        {
          'text': 'Kimi no kakera',
          'isTrue': false,
        },
        {
          'text': 'Sono hi no koto',
          'isTrue': false,
        },
      ]
    },
    {
      'question': 'What\'s your favorite ide?',
      'answer': [
        {
          'text': 'VSCode',
          'isTrue': true,
        },
        {
          'text': 'Visual Studio',
          'isTrue': false,
        },
        {
          'text': 'Atom',
          'isTrue': false,
        },
        {
          'text': 'Inteliji',
          'isTrue': false,
        },
      ]
    },
    {
      'question': 'What\'s your favorite place?',
      'answer': [
        {
          'text': 'New York',
          'isTrue': false,
        },
        {
          'text': 'Santorini',
          'isTrue': false,
        },
        {
          'text': 'Yokohama',
          'isTrue': true,
        },
      ]
    }
  ];

  var _questionIndex = 0;
  void _answerQuestion(bool isTrue) {
    setState(() {
      if (_questionIndex >= _questions.length) return;
      _questionIndex++;
      _score+=(isTrue)?1:0;
    });

    print(_questionIndex);
  }

  void _replay() {
    setState(() {
      _questionIndex = 0;
      _score=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz Application'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questions: _questions,
                questionIndex: _questionIndex,
              )
            : Result(_score,_replay,),
      ),
    );
  }
}
