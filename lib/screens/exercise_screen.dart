import 'package:flutter/material.dart';
import 'package:juego_sumas/model/levels.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/widgets/options.dart';
import 'package:juego_sumas/widgets/operation.dart';
import 'package:juego_sumas/widgets/progress_bar.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';

class ExerciseScreen extends StatelessWidget {
  static const routeName = './operation';

  @override
  Widget build(BuildContext context) {
    final level = ModalRoute.of(context).settings.arguments;
    final stage = ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider<ExerciseSequence>(
      builder: (context) => Provider.of<LevelService>(context, listen: false)
          .generateExerciseSequence(level, stage, count: 2),
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 15,
              child: ProgressBar(),
            ),
            Expanded(
              flex: 45,
              child: Operation(),
            ),
            Spacer(flex: 5),
            Expanded(
              flex: 25,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: DigitKeyboard(),
              ),
            ),
            Expanded(
              flex: 15,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Consumer<ExerciseSequence>(
                  builder: (context, exerciseSequence, child) {
                    return !exerciseSequence.isCorrect
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                           children: <Widget>[
                             Container(
                               height: 45,
                               width: double.infinity,
                               child: FlatButton(
                                color: Colors.amber[200],
                                shape: StadiumBorder(),
                                child: Text('Corregir'),
                                onPressed: () {
                                  exerciseSequence.checkResult();
                                  print(exerciseSequence.progress);
                                },
                            ),
                             ),
                          ], 
                        )
                        : 
                        Container(
                          height: 45,
                          width: double.infinity,
                          color: Colors.green[200],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Bien hecho!', style: TextStyle(fontSize: 18),),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(left: 5, right: 5 ),
                                child: FlatButton(
                                  color: Colors.green[400],
                                  shape: StadiumBorder(),
                                  child: Text('Siguiente'),
                                  onPressed: () {
                                    if (exerciseSequence.finished) {
                                      // TODO: Show 'WELL DONE'animation
                                      print('finish');
                                      Navigator.of(context).pop();
                                    } else {
                                      print('next');
                                      exerciseSequence.next();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
