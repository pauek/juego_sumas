import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';
import 'package:flutter/animation.dart';

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
        width: 60,
        height: 120,
        child: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            width: seq.selectedDigit == index ? 55 : 45,
            padding: seq.selectedDigit == index
                ? EdgeInsets.symmetric(horizontal: 7.5, vertical: 5)
                : EdgeInsets.only(right: 3, left: 3),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.black12, width: 3),
            ),
            child: Text(
              (seq.number[index] == -1 ? ' ' : '${seq.number[index]}'),
              style: TextStyle(fontSize: 76),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
