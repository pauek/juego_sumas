import 'package:flutter/foundation.dart';
import 'package:juego_sumas/database/database.dart';
import 'package:juego_sumas/model/exercise.dart';
import 'package:juego_sumas/utils/UserManager.dart';

import 'log.dart';

/*

Exercise sequence
-----------------

Un ExerciseSequence és un objecte amb estat que permet saber on estàs d'una
sèrie d'exercicis.

Es pot generar a partir d'un LevelService (donat un nivell, li pots demanar que et
generi exercicis i els vas afegint a una seqüència)


*/

class ExerciseSequence with ChangeNotifier {
  List<Exercise> exercises = [];
  int _current = 0;

  List<int> number = List<int>.generate(10, (i) => -1);

  int _selectedDigit = 0;

  bool _correct = false;

  bool _error = false;

  int _progress = 0;

  int errors = 0;

  Log exerciseLog;

  int get selectedDigit => _selectedDigit;

  set selectedDigit(int newValue) {
    _selectedDigit = newValue;
    notifyListeners();
  }

  void setDigit(int value) {
    number[_selectedDigit] = value;
    // _selectedDigit++;
    if (_selectedDigit >= current.result.length) {
      _selectedDigit = 0;
    }
    notifyListeners();
  }

  addSequence(Exercise e, int level, String group) {
    exercises.add(e);
    exerciseLog = new Log(
      startTime: DateTime.now(),
      levelIndex: level,
      nextGroup: group,
    );
  }

  Exercise get current =>
      (_current < exercises.length ? exercises[_current] : null);

  double get progress => _progress / exercises.length;

  bool get finished => _progress >= exercises.length;

  bool get isCorrect => _correct;

  bool get isError => _error;

  bool get isLevelDone => errors <= 3;

  void checkResult() {
    for (int i = 0; i < current.result.length; i++) {
      if (current.result[i] != number[i]) {
        _correct = false;
        _error = true;
        errors++;
        break;
      } else {
        _correct = true;
        _error = false;
      }
    }
    _progress++;
    notifyListeners();
  }

  void next() {
    if (_current < exercises.length) {
      _current++;
      _selectedDigit = 0;
      number = List<int>.generate(10, (i) => -1);
      _correct = false;
      _error = false;
      notifyListeners();
    } else {}
  }

  void submitData() {
    exerciseLog.endTime = DateTime.now();
    exerciseLog.didWin = errors > 3;

    DataBase.sendLog(UserManager.kidId, exerciseLog);
  }
}
