import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';
import 'package:flutter/animation.dart';

class SelectableCarry extends StatelessWidget {
  // final int index;
  // SelectableDigit(this.index);

  final int index = 0;

  @override
  Widget build(BuildContext context) {
    final seq = Provider.of<ExerciseSequence>(context);
    final color =
        (seq.selectedDigit == index ? Colors.blue[100] : Colors.white);

    return GestureDetector(
      onTap: () {
        seq.selectedDigit = index;
      },
      child: Column(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            width: seq.selectedDigit == index ? 45 : 35,
            margin: EdgeInsets.symmetric(horizontal: 2.5),
            padding: seq.selectedDigit == index
                ? EdgeInsets.symmetric(horizontal: 2, vertical: 2)
                : EdgeInsets.only(right: 0, left: 0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.black12, width: 3),
            ),
            child: Text(
              (seq.number[index] == -1 ? ' ' : '${seq.number[index]}'),
              style: TextStyle(fontSize: 26),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
