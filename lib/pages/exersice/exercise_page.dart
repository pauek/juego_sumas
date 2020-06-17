import 'package:flutter/material.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';
import 'package:juego_sumas/model/levels.dart';
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

    final mainColor = Provider.of<LevelService>(context).getColor(stageIndex);

    return ChangeNotifierProvider<ExerciseSequence>(
      builder: (context) => Provider.of<LevelService>(context, listen: false)
          .generateExerciseSequence(stageIndex, levelIndex),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: ProgressBar(mainColor),
              ),
              Expanded(
                flex: 50,
                child: Operation(mainColor),
              ),
              Expanded(
                flex: 20,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: DigitKeyboard(mainColor),
                ),
              ),
              Expanded(
                flex: 15,
                child: Consumer<ExerciseSequence>(
                    builder: (context, exerciseSequence, child) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      AnimatedContainer(
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 900),
                        height: exerciseSequence.isError ||
                                exerciseSequence.isCorrect
                            ? 500
                            : 0,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                              color: !exerciseSequence.isError
                                  ? exerciseSequence.isCorrect
                                      ? Colors.green[100]
                                      : Colors.transparent
                                  : Colors.red[100],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Style.body(
                                _getText(exerciseSequence.isError,
                                    exerciseSequence.isCorrect),
                                textAlign: TextAlign.center,
                                color: Colors.black26),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: !exerciseSequence.isError
                            ? exerciseSequence.isCorrect
                                ? Container(
                                    height: 50,
                                    child: Style.button("SIGUIENTE", () {
                                      if (exerciseSequence.finished) {
                                        exerciseSequence.submitData();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WinScreen(
                                                    didWin: exerciseSequence
                                                        .isLevelDone,
                                                  )),
                                        );
                                      } else {
                                        print('next');
                                        exerciseSequence.next();
                                      }
                                    }, color: Colors.green[200]),
                                  )
                                : Container(
                                    height: 50,
                                    child: Style.button("COMPROBAR", () {
                                      exerciseSequence.checkResult();
                                    }, color: Colors.amber[200]),
                                  )
                            : Container(
                                height: 50,
                                child: Style.button("SIGUIENTE", () {
                                  if (exerciseSequence.finished) {
                                    exerciseSequence.submitData();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WinScreen(
                                                didWin: exerciseSequence
                                                    .isLevelDone,
                                              )),
                                    );
                                  } else {
                                    print('next');
                                    exerciseSequence.next();
                                  }
                                }, color: Colors.red[200]),
                              ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getText(isError, isCorrect) {
    if (!isCorrect && isError) {
      return "Error, sigue intentandolo!";
    }
    if (isCorrect && !isError) {
      return "¡Bien hecho!";
    }
    return '';
  }
}
