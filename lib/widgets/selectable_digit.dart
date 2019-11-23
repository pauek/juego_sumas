
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';

class SelectableDigit extends StatelessWidget {
  final int index;
  SelectableDigit(this.index);

  @override
  Widget build(BuildContext context) {
    final seq = Provider.of<ExerciseSequence>(context);
    final color =
        (seq.selectedDigit == index ? Colors.blue[100] : Colors.white);
    return GestureDetector(
      onTap: () {
        seq.selectedDigit = index;
      },
      child: Container(
        width: 45,
        margin: EdgeInsets.only(left: 5),
        padding: EdgeInsets.only( right: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.blue[400], width: 1),
        ),
        child: Text(
          (seq.number[index] == -1 ? ' ' : '${seq.number[index]}'),
          style: TextStyle(fontSize: 76),
        ),
      ),
    );
  }
}