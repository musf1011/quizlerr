import 'package:flutter/material.dart';
import 'package:quizlerr/quiz_brain.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
            child: Quizzler(),
          ),
        ),
      ),
    ),
  );
}

class Quizzler extends StatefulWidget {
  const Quizzler({super.key});

  @override
  State<Quizzler> createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  QuizBrain quizBrain = QuizBrain();
  final List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickAnswer) {
    setState(() {
      if (quizBrain.isFinished() == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Finished!'),
            content: Text('You\'ve reached the end of the quiz.'),
          ),
        );
        quizBrain.reset();
        scoreKeeper.clear();
      } else {
        if (quizBrain.getQuestionAnswer() == userPickAnswer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                style: TextStyle(fontSize: 25.0, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),

            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                checkAnswer(true);
              },
              child: Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                checkAnswer(false);
              },
              child: Text(
                'False',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Row(children: scoreKeeper),
      ],
    );
  }
}
