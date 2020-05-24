import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  final Color currentColor;

  ProgressBar(this.currentColor);

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ExerciseSequence>(context).progress;
    print(progress);
    return LayoutBuilder(builder: (ctx, constrains) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: constrains.maxWidth * 0.1,
            child: IconButton(
              icon: Icon(Icons.close),
              color: currentColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          LinearPercentIndicator(
            width: constrains.maxWidth * 0.8,
            lineHeight: 15.0,
            percent: progress < 1 ? progress + 0.01 : progress - 0.03,
            backgroundColor: Colors.amber[100],
            progressColor: currentColor,
            animationDuration: 520,
            animation: true,
            animateFromLastPercent: true,
          )
        ],
      );
    });
  }
}
