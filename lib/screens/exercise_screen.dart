import 'package:flutter/material.dart';
import 'package:juego_sumas/model/levels.dart';
import 'package:juego_sumas/widgets/custom_buton.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/widgets/options.dart';
import 'package:juego_sumas/widgets/operation.dart';
import 'package:juego_sumas/widgets/progress_bar.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';

class ExerciseScreen extends StatelessWidget {
  static const routeName = './operation';

  @override
  Widget build(BuildContext context) {
    final List<int> args = ModalRoute.of(context).settings.arguments;
    final int stageIndex = args[0];
    final int levelIndex = args[1];

    return ChangeNotifierProvider<ExerciseSequence>(
      builder: (context) => Provider.of<LevelService>(context, listen: false)
          .generateExerciseSequence(stageIndex, levelIndex, count: 2),
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
                                child: GestureDetector(
                                  onTap: () {
                                    exerciseSequence.checkResult();
                                    print(exerciseSequence.progress);
                                  },
                                  child: CustomButton(
                                      height: 45,
                                      width: double.infinity,
                                      isCircle: false,
                                      child: Text(
                                        'Corregir',
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 18),
                                        textAlign: TextAlign.center,
                                      ),
                                      color: Colors.amber[200]),
                                ),
                              ),
                            ],
                          )
                        : AnimatedContainer(
                            duration: Duration(seconds: 1),
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              //   border:
                              //       Border.all(color: Colors.black12, width: 3),
                            ),
                            height: 45,
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Bien hecho!',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  child: GestureDetector(
                                    child: CustomButton(
                                      height: 45,
                                      width: 45,
                                      color: Colors.green[400],
                                      isCircle: false,
                                      child: Text(
                                        'Siguiente',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    onTap: () {
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
