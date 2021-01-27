import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answer;
  final Function buttonClicked;

  Answer(this.buttonClicked, this.answer);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue[200],
        child: Text(this.answer),
        onPressed: this.buttonClicked,
      ),
    );
  }
}
