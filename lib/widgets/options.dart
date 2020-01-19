import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';

class DigitKeyboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final exerciseSequence = Provider.of<ExerciseSequence>(context);

   

    return !exerciseSequence.isCorrect ? GridView.count(
      crossAxisCount: 5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 7,
      children: List.generate(10, (index) {
        return Container(
          height: 50,
          width: 50,
          child: FlatButton(
            shape: StadiumBorder(),
            color: Colors.blue[200],
            textColor: Colors.white,
            onPressed: () {
              exerciseSequence.setDigit(index);
            },
            child: Text(
              '$index',
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      }),
    ) 
    : 
   Container(); 
  }
}
