import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';
import 'package:provider/provider.dart';

class SelectableCarry extends StatefulWidget {
  final Color currentColor;
  final int index;
  SelectableCarry(this.currentColor, this.index);
  @override
  _SelectableCarryState createState() => _SelectableCarryState();
}

class _SelectableCarryState extends State<SelectableCarry> {
  bool carry = false;

  @override
  Widget build(BuildContext context) {
    final seq = Provider.of<ExerciseSequence>(context);

    return GestureDetector(
      onTap: () {
        seq.setCarry(!carry); // TODO: fix this part! 
        setState(() {
          carry = !carry;
        });
      },
      child: Align(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          width: 42,
          height: 42,
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(
              color: (seq.selectedDigit != widget.index
                  ? Colors.amber[100]
                  : widget.currentColor),
              width: 4,
            ),
            // color: (carry ? Colors.amber[100] : Colors.white),
          ),
          child: Center(
            child: Text(
              (seq.usedCarry[seq.selectedDigit] ? '1' : ''),
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  height: 1.2),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
