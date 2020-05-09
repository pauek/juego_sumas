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
      child: seq.selectedDigit == index
          ? Container(
              margin: EdgeInsets.only(top: 5),
              width: 60,
              height: 110,
              child: Center(
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: seq.selectedDigit == index ? 60 : 45,
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
                    style: TextStyle(
                      fontSize: 76,
                      color: Colors.black.withOpacity(0.8),
                      height: 1.4
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.only(right: 5),
              width: 60,
              height: 110,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.amber[200], width: 5),
                ),
              ),
              child: Text(
                (seq.number[index] == -1 ? ' ' : '${seq.number[index]}'),
                style: TextStyle(
                  fontSize: 76,
                  color: Colors.black.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
