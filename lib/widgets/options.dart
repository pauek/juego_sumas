import 'package:flutter/material.dart';
import 'package:juego_sumas/widgets/custom_buton.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';

class DigitKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final exerciseSequence = Provider.of<ExerciseSequence>(context);

    return !exerciseSequence.isCorrect
        ? GridView.count(
          physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 7,
            children: List.generate(10, (index) {
              return GestureDetector(
                onTap: () {
                  exerciseSequence.setDigit(index);
                },
                child: CustomButton(
                  height: 50,
                  width: 50,
                  color: Colors.blue[200],
                  isCircle: true,
                  child: Text(
                    '$index',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }),
          )
        : Container(
          height: 15,
        );
  }
}
