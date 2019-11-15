import 'package:flutter/material.dart';
import 'package:juego_sumas/model/exercise.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';

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
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          for (int i = digits.length - 1; i >= 0; i--) ...[
            SizedBox(width: 5),
            Container(
              color: (exerciseSequence.selectedDigit == i ? Colors.blue : Colors.white),
              child: Text(
                (digits[i] == -1 ? ' ' : '${digits[i]}'),
                style: TextStyle(fontSize: 76),
              ),
            ),
          ]
        ]),
      ],
    );
  }
}

/*

Container(
              height: 85,
              width: 50,
              margin: EdgeInsets.only(top: 5),
              child: TextField(
                focusNode: AlwaysDisabledFocusNode(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.00),
                  ),
                ),
                style: ,
                onChanged: (value) {
                  // updateResult.insertResult(exerciceId, int.parse(value), 1);
                },
              ),
            ),
            Container(
              height: 85,
              width: 50,
              margin: EdgeInsets.only(left: 5, top: 5),
              child: TextField(
                focusNode: AlwaysDisabledFocusNode(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.00),
                  ),
                ),
                style: TextStyle(fontSize: 35),
                onChanged: (value) {
                  // updateResult.insertResult(exerciceId, int.parse(value), 0);
                },
              ),
            ),
            */

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
