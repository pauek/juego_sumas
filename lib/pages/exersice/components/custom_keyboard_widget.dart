import 'package:flutter/material.dart';
import 'package:juego_sumas/utils/style.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';

class DigitKeyboard extends StatelessWidget {
  final Color currentColor;
  DigitKeyboard(this.currentColor);

  @override
  Widget build(BuildContext context) {
    final exerciseSequence = Provider.of<ExerciseSequence>(context);

    return !exerciseSequence.isCorrect && !exerciseSequence.isError
        ? GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 7,
            children: List.generate(10, (index) {
              return FlatButton(
                onPressed: () {
                  exerciseSequence.setDigit(index);
                },
                color: currentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                      color: Colors.black12,
                      width: 4,
                      style: BorderStyle.solid,
                    )),
                child: Style.body('$index',
                    color: Colors.black26,
                    textAlign: TextAlign.center,
                    fontSize: 32),
              );
            }),
          )
        : Container(
            // height: 15,
            );
  }
}
