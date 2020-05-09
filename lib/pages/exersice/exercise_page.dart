import 'package:flutter/material.dart';
import 'package:juego_sumas/database/database.dart' as db;
import 'package:juego_sumas/model/exercise_sequence.dart';
import 'package:juego_sumas/model/levels.dart';
import 'package:juego_sumas/model/log.dart';
import 'package:juego_sumas/pages/exersice/components/custom_keyboard_widget.dart';
import 'package:juego_sumas/pages/exersice/components/operation.dart';
import 'package:juego_sumas/pages/exersice/components/progress_bar_widget.dart';
import 'package:juego_sumas/utils/style.dart';
import 'package:provider/provider.dart';

import '../win_screen.dart';

class ExercisePage extends StatelessWidget {
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
              Expanded(
                flex: 20,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: DigitKeyboard(),
                ),
              ),
              Expanded(
                flex: 15,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Consumer<ExerciseSequence>(
                        builder: (context, exerciseSequence, child) {
                      return !exerciseSequence.isError
                          ? exerciseSequence.isCorrect
                              ? Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      )),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Style.body("¡Bien hecho!",
                                          textAlign: TextAlign.center,
                                          color: Colors.black26),
                                      Container(
                                        height: 50,
                                        child: Style.button("SIGUIENTE", () {
                                          if (exerciseSequence.finished) {
                                            print('finish');
                                            db.sendLog(
                                                'eYA6mXfzQf0sAnZNdnmb',
                                                Log(
                                                    levelId:
                                                        '0', // todo: get levelID
                                                    startTime: DateTime.now(),
                                                    endTime: DateTime.now()));

                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    WinScreen.routeName);
                                          } else {
                                            print('next');
                                            exerciseSequence.next();
                                          }
                                        }, color: Colors.green[200]),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  height: 50,
                                  child: Style.button("COMPROBAR", () {
                                    exerciseSequence.checkResult();
                                  }, color: Colors.amber[200]),
                                )
                          : Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  )),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Style.body("Error, sigue intentandolo!",
                                      textAlign: TextAlign.center,
                                      color: Colors.black26),
                                  Container(
                                    height: 50,
                                    child: Style.button("SIGUIENTE", () {
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
                                    }, color: Colors.red[200]),
                                  ),
                                ],
                              ),
                            );
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
