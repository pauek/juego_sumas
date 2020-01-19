import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';
import 'package:flutter/animation.dart';
import 'package:juego_sumas/widgets/options.dart';
import 'package:overlay_container/overlay_container.dart';

class SelectableDigit extends StatelessWidget {
  final int index;
  SelectableDigit(this.index);

  @override
  Widget build(BuildContext context) {
    final seq = Provider.of<ExerciseSequence>(context);
    final color =
        (seq.selectedDigit == index ? Colors.blue[100] : Colors.white);
    // final animatedWidth =  ;
    return GestureDetector(
      onTap: () {
        seq.selectedDigit = index;
      },
      child: Column(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            width: seq.selectedDigit == index ? 55 : 45,
            // width: 45,
            // height: seq.selectedDigit == index ? 45 : 35,
            margin: EdgeInsets.only(left: 5),
            padding: seq.selectedDigit == index
                ? EdgeInsets.symmetric(horizontal: 7.5, vertical: 5)
                : EdgeInsets.only(right: 3, left: 3),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.blue[200], width: 1),
            ),
            child: Text(
              (seq.number[index] == -1 ? ' ' : '${seq.number[index]}'),
              style: TextStyle(fontSize: 76),
              textAlign: TextAlign.center,
            ),
          ),
          // OverlayContainer(
          //   show: seq.selectedDigit == index ? true : false,
          //   position: OverlayContainerPosition(-45, 0),
          //   // child: DigitKeyboard(),
          //   child: FlatButton(
          //     onPressed: () {},
          //     color: Colors.red,
          //     child: Text('hellooo'),
          //   ),
          // )
        ],
      ),
    );
  }
}
