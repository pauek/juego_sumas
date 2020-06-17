import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';
import 'package:flutter/animation.dart';

class SelectableDigit extends StatelessWidget {
  final int index;
  final Color currentColor;
  SelectableDigit(this.index, this.currentColor);

  @override
  Widget build(BuildContext context) {
    final seq = Provider.of<ExerciseSequence>(context);
    final color = (seq.selectedDigit == index ? currentColor : Colors.white);
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        seq.selectedDigit = index;
      },
      child: seq.selectedDigit == index && !seq.isError && !seq.isCorrect
          ? Container(
              margin: EdgeInsets.only(top: 5),
              width: 60,
              height: height * 0.13,
              child: Center(
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: 60,
                  padding: seq.selectedDigit == index
                      ? EdgeInsets.symmetric(horizontal: 5, vertical: 5)
                      : EdgeInsets.only(right: 3, left: 3),
                  decoration: BoxDecoration(
                    // color: color,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: color, width: 5),
                  ),
                  child: Text(
                    (seq.number[index] == -1 ? ' ' : '${seq.number[index]}'),
                    style: TextStyle(
                        fontSize: 76,
                        color: Colors.black.withOpacity(0.8),
                        height: 1.2),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.only(right: 5, top: 5),
              width: 60,
              height: height * 0.13,
              padding: EdgeInsets.symmetric(vertical: 5),
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
                  height: 1.3
                ),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
