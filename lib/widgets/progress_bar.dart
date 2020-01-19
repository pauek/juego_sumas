import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<ExerciseSequence>(context).progress;
    // print(progress / 100);
    return LayoutBuilder(builder: (ctx, constrains) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: constrains.maxWidth * 0.1,
            child: IconButton(
              icon: Icon(Icons.close),
              color: Colors.blue[200],
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          LinearPercentIndicator(
            width:  constrains.maxWidth * 0.8,
                lineHeight: 15.0,
                percent: progress < 1 ? progress + 0.03 : progress,
                backgroundColor: Colors.amber[100],
                progressColor: Colors.blue[200],
                animationDuration: 520,
                animation: true,
          )
          // Container(
          //   // margin: EdgeInsets.only(top: 45),
          //   height: 15,
          //   width: constrains.maxWidth * 0.8,
          //   child: Stack(
          //     children: <Widget>[
          //       Container(
          //         decoration: BoxDecoration(
          //             // border: Border.all(
          //             //   color: Colors.blue[200],
          //             //   width: 1.0,
          //             // ),
          //             color: Colors.amber[100],
          //             borderRadius: BorderRadius.circular(10)),
          //       ),
          //       FractionallySizedBox(
          //         widthFactor: progress,
          //         child: Container(
          //           decoration: BoxDecoration(
          //             color: Colors.blue[200],
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      );
    });
  }
}
