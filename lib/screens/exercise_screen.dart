import 'package:flutter/material.dart';
import 'package:juego_sumas/model/exercise.dart';
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

    return Provider<ExerciseSequence>(
      builder: (context) => Provider.of<LevelService>(context, listen: false)
          .generateExerciseSequence(level),
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
                child: Options(),
              ),
              
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Consumer<ExerciseSequence>(
                  builder: (context, exerciseSequence, child) {
                    return FlatButton(
                      color: Colors.green[200],
                      shape: StadiumBorder(),
                      child: Text('Submit'),
                      onPressed: () {
                        if (exerciseSequence.finished) {
                          Navigator.of(context)
                              .pushReplacementNamed('./');
                          return;
                        }
                        final Exercise ex = exerciseSequence.current;
                        if (ex.top[0] == ex.result[0] &&
                            ex.top[1] + ex.bottom[0] == ex.result[1]) {
                          exerciseSequence.next();
                          // TODO: Show 'WELL DONE'
                        }
                      },
                    );
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
