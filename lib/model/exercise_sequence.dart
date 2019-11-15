import 'package:juego_sumas/model/exercise.dart';

/*

Exercise sequence
-----------------

Un ExerciseSequence és un objecte amb estat que permet saber on estàs d'una
sèrie d'exercicis.

Es pot generar a partir d'un LevelService (donat un nivell, li pots demanar que et
generi exercicis i els vas afegint a una seqüència)


*/

class ExerciseSequence {
  List<Exercise> exercises = [];
  int _current = 0;
  List<int> number = [];

  add(Exercise e) => exercises.add(e);

  Exercise get current => exercises[_current];
  
  double get progress => _current / exercises.length;

  bool get finished => _current >= exercises.length;

  void addDigit(int digit) => number.add(digit);

  bool checkResult() {
    if (current.result.length != number.length) {
      return false;
    }
    for (int i = 0; i < current.result.length; i++) {
      if (current.result[i] != number[i]) {
        return false;
      }
    }
    return true;
  }

  void next() {
    if (_current < exercises.length) _current++;
  }
}
