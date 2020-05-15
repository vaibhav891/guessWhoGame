import 'package:flutter/material.dart';
import 'package:guess_who_game/characters.dart';
import 'dart:ui' as ui;

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    Key key,
  }) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  var questions = [
    ['Is your character a Male?', 'gender', 'male'],
    ['Does your character wear glasses?', 'glasses', true],
    ['Does your character have facial hair?', 'facialHair', true],
    ['Is your character wearing blue dress?', 'dressColor', 'blue'],
    ['Is your characrter\'s hair of black color?', 'hairColor', 'black'],
    ['Does your character have mushtaches?', 'mushtache', true],
    ['Does your character have beard?', 'beard', true],
    ['Is your character wearing ear-rings?', 'earRings', true],
    ['Is your character bald?', 'baldness', true],
    ['Is your character wearing a hat or a cap?', 'headgear', true],
    ['Is your characrter\'s hair blonde/yellow?', 'hairColor', 'blonde'],
    ['Does your character have grey hair?', 'hairColor', 'grey'],
    ['Is your characrter\'s hair of orange color?', 'hairColor', 'orange'],
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Flexible(
        child: Container(
          //color: Colors.grey[300],
          padding: EdgeInsets.all(5.0),
          child: Text(
            questions[index][0],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35.0,
              foreground: Paint()
                ..shader = ui.Gradient.linear(
                  const Offset(0, 20),
                  const Offset(150, 20),
                  <Color>[
                    Colors.black,
                    Colors.blueGrey[900],
                  ],
                ),
              //color: Colors.purple[900],
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      Flexible(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Flexible(
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                characters.removeWhere((element) =>
                    element[questions[index][1]] != questions[index][2]);

                if (characters.length == 1) {
                  showDialog(
                      context: context,
                      builder: (context) => MyDialog(
                          msgText: 'You selected ' + characters[0]['name']));
                } else if (characters.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) => MyDialog(
                          msgText:
                              'OOPS... Looks like something went wrong. I do not have a character matching those features!'));
                } else {
                  setState(() {
                    if (index < questions.length - 1) {
                      index++;
                    }
                  });
                }
              },
              child: Text(
                'YES',
                style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.black,
                    ),
              ),
            ),
          ),
          Flexible(
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                characters.removeWhere((element) =>
                    element[questions[index][1]] == questions[index][2]);
                if (characters.length == 1) {
                  showDialog(
                      context: context,
                      builder: (context) => MyDialog(
                          msgText: 'You selected ' + characters[0]['name']));
                } else if (characters.isEmpty ||
                    index == (questions.length - 1)) {
                  showDialog(
                      context: context,
                      builder: (context) => MyDialog(
                          msgText:
                              'OOPS... Looks like something went wrong. I do not have a character matching those features!'));
                } else {
                  setState(() {
                    if (index < questions.length - 1) {
                      index++;
                    }
                  });
                }
              },
              child: Text(
                'No',
                style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.black,
                    ),
              ),
            ),
          )
        ]),
      ),
    ]);
  }
}

class MyDialog extends StatelessWidget {
  final String msgText;

  const MyDialog({Key key, this.msgText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(msgText),
      actions: [
        RaisedButton(
          onPressed: () {
            Navigator.of(context)..pop()..pop();
            //Navigator.pop(context);
          },
          child: Text('OK'),
        )
      ],
    );
  }
}
