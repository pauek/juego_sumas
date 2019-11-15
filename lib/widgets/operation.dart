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
    // TODO(mese): change to GetNumbers() ???
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



    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.end,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        getText(exercise.top.reversed, false),
        getText(exercise.bottom.reversed, true),
        Container(
          width: 180,
          height: 3,
          color: Colors.black,
          margin: EdgeInsets.symmetric(vertical: 5),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          for (int i = digits.length - 1; i >= 0; i--)
            SelectableDigit(i),
        ]),
      ],
    );
  }
}


