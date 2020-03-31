import 'package:flutter/material.dart';
import 'package:juego_sumas/database/database.dart' as db;
import 'package:juego_sumas/model/exercise_sequence.dart';
import 'package:juego_sumas/model/levels.dart';
import 'package:juego_sumas/model/log.dart';
import 'package:juego_sumas/screens/win_screen.dart';
import 'package:juego_sumas/widgets/custom_buton.dart';
import 'package:juego_sumas/widgets/operation.dart';
import 'package:juego_sumas/widgets/options.dart';
import 'package:juego_sumas/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

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
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: ProgressBar(),
              ),
              Expanded(
                flex: 50,
                child: Operation(),
              ),
              // Spacer(flex: 5),
              Expanded(
                flex: 20,
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
                                    },
                                    child: CustomButton(
                                        height: 45,
                                        width: double.infinity,
                                        isCircle: false,
                                        child: Text(
                                          !exerciseSequence.isError
                                              ? 'Corregir'.toUpperCase()
                                              : 'Reintentar'.toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        color: !exerciseSequence.isError
                                            ? Colors.amber[200]
                                            : Colors.red[200]),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              // duration: Duration(seconds: 1),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              height: 45,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Bien hecho!',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
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
                                          'Siguiente'.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      onTap: () {
                                        if (exerciseSequence.finished) {
                                          print('finish');
                                          db.sendLog(
                                              'eYA6mXfzQf0sAnZNdnmb',
                                              Log(
                                                  levelId: '0',
                                                  startTime: DateTime.now(),
                                                  endTime: DateTime.now()));

                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  WinScreen.routeName);
                                        } else {
                                          print('next');
                                          exerciseSequence.next();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
