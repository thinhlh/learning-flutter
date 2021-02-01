import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final Function replay;
  final int score;

  Result(this.score,this.replay);
  String get resultPhrashe{
    return 'Congratulation you completed all the quiz!\nYour final point is $score';
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
        children: [
          Text(
            resultPhrashe,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          RaisedButton(
            onPressed: replay,
            child: Text('Replay'),
            color: Colors.blueAccent[100],
          )
        ],
      ),
    );
  }
}
