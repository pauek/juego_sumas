import 'dart:math';

import 'package:flutter/material.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';
import 'package:juego_sumas/pages/exersice/components/selectable_digit.dart';
import 'package:juego_sumas/utils/style.dart';
import 'package:juego_sumas/widgets/selectable_carry.dart';
import 'package:provider/provider.dart';

class Operation extends StatefulWidget {
  final Color currentColor;
  Operation(this.currentColor);
  @override
  _OperationState createState() => _OperationState();
}

class _OperationState extends State<Operation> {
  Widget _digit(int num) {
    if (num == null) {
      return Container();
    }
    return Style.body(
      num.toString(),
      fontSize: 86,
      height: 1.0,
      color: Colors.black.withOpacity(0.8),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    final exerciseSequence = Provider.of<ExerciseSequence>(context);
    final exercise = exerciseSequence.current;

    if (exercise == null) {
      // FIXME: Aquí s'hauria de donar un error.
      return Container();
    }

    final top = exercise.maxedTop;
    final bottom = exercise.maxedBottom;
    final result = exercise.result;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Center(
          child: Table(
            defaultColumnWidth: IntrinsicColumnWidth(),
            defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
            children: [
              TableRow(
                children: <Widget>[
                  Container(),
                  for (int i = top.length - 1; i >= 0; i--) SelectableCarry(),
                ],
              ),
              TableRow(
                children: [
                  Container(),
                  for (var d in top.reversed) _digit(d),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10, bottom: 10),
                    child: Icon(
                      Icons.add,
                      size: 60,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  for (var d in bottom.reversed) _digit(d)
                ],
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 3, color: Colors.black.withOpacity(0.8))),
                ),
              ),
              TableRow(
                children: [
                  Container(),
                  for (int i = result.length - 1; i >= 0; i--)
                    SelectableDigit(i, widget.currentColor),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
