import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';
import 'package:juego_sumas/widgets/selectable_digit.dart';

class Operation extends StatefulWidget {
  @override
  _OperationState createState() => _OperationState();
}

class _OperationState extends State<Operation> {
  @override
  Widget build(BuildContext context) {
    final exerciseSequence = Provider.of<ExerciseSequence>(context);
    final exercise = exerciseSequence.current;

    if (exercise == null) {
      return Container();
    }

    Widget getText(numbers, isBottom) {
      String newNumber = '';
      if (isBottom) {
        newNumber = '+ ';
      }
      numbers.forEach(
        (n) => newNumber = '$newNumber$n',
      );
      return Text(
        newNumber,
        style: TextStyle(fontSize: 76),
      );
    }

    final digits =
        exerciseSequence.number.take(exercise.result.length).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '+',
                    style: TextStyle(fontSize: 76),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // SelectableDigit(1), 
                          getText(exercise.top.reversed, false),
                        ],
                      ),
                      getText(exercise.bottom.reversed, false),
                    ],
                  ),
                ],
              ),
              Container(
                width: (65.0 * exercise.result.length),
                child: Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = digits.length - 1; i >= 0; i--)
                    SelectableDigit(i),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
