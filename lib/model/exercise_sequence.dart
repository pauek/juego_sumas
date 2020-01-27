import 'package:flutter/foundation.dart';
import 'package:juego_sumas/model/exercise.dart';

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

  int _progress = 0;

  int get selectedDigit => _selectedDigit;

  set selectedDigit(int newValue) {
    _selectedDigit = newValue;
    notifyListeners();
  }

  void setDigit(int value) {
    number[_selectedDigit] = value;
    _selectedDigit++;
    if (_selectedDigit >= current.result.length) {
      _selectedDigit = 0;
    }
    notifyListeners();
  }

  add(Exercise e) => exercises.add(e);

  Exercise get current =>
      (_current < exercises.length ? exercises[_current] : null);

  double get progress => _progress / exercises.length ;

  bool get finished => _progress >= exercises.length;

  bool get isCorrect => _correct;

  void checkResult() {
    for (int i = 0; i < current.result.length; i++) {
      if (current.result[i] != number[i]) {
        // return false;
        _correct = false;
        break;
      } else {
        _progress++;
        _correct = true;
      }
    }
    notifyListeners();
    // return true;
  }

  void next() {
    if (_current < exercises.length) {
      print(_progress);
      _current++;
      _selectedDigit = 0;
      number = List<int>.generate(10, (i) => -1);
      _correct = false;
      notifyListeners();
    }
  }
}
