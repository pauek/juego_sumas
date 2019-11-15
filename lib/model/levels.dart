import 'dart:math';
import 'package:juego_sumas/model/exercise.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';

final rnd = Random();

int randIntInclusive(int min, int max) {
  if (min == max) {
    return min;
  }
  return rnd.nextInt((max + 1) - min) + min;
}

class Level {
  int sizeTop, sizeBottom, sizeResult;
  List<bool> carry = [];
  List<int> dependencies;

  Level(this.sizeTop, this.sizeBottom, String scarry,
      this.dependencies) {
    final sizeMax = max(sizeTop, sizeBottom);
    assert(scarry.length == sizeMax);
    carry =
        List<bool>.generate(scarry.length, (i) => scarry[i] == 'c');
    sizeResult = sizeMax + (carry.last ? 1 : 0);
  }
}

class Number {
  List<int> digits;
  Number(int size) : digits = List<int>.filled(size, -1);

  int get value =>
      digits.reversed.reduce((sum, digit) => 10 * sum + digit);
  String toString() =>
      digits.reversed.map((d) => '$d').toList().join('');
  bool selfCheck() => digits.every((n) => n >= 0 && n <= 9);

  int get last => digits.last;
  int get length => digits.length;
}

enum Pos { top, bottom, result }

class LevelInstance {
  Level level;
  Map<Pos, Number> numbers;

  LevelInstance(this.level) {
    numbers = {
      Pos.top: Number(level.sizeTop),
      Pos.bottom: Number(level.sizeBottom),
      Pos.result: Number(level.sizeResult),
    };
  }

  Number get top => numbers[Pos.top];
  Number get bottom => numbers[Pos.bottom];
  Number get result => numbers[Pos.result];

  selfCheck() {
    assert(top.selfCheck());
    assert(bottom.selfCheck());
    assert(result.selfCheck());
    assert(top.length == 1 || top.last > 0);
    assert(bottom.length == 1 || bottom.last > 0);
    assert(top.value + bottom.value == result.value);
  }

  void _generateColumns() {
    for (int i = 0; i < level.sizeResult; i++) {
      if (i >= level.sizeBottom && i >= level.sizeTop) {
        // Las dos cifras estan vacías (es solo un carry)
        assert(i == level.carry.length && level.carry.last);
        result.digits[i] = 1;
        return;
      }

      final bool carryLast = (i > 0 && level.carry[i - 1]);
      final bool carryNow =
          (i < level.carry.length && level.carry[i]);
      final Map<Pos, bool> lastDigit = {
        Pos.top: i == level.sizeTop - 1,
        Pos.bottom: i == level.sizeBottom - 1,
      };
      final Map<Pos, bool> singleDigit = {
        Pos.top: i >= level.sizeBottom,
        Pos.bottom: i >= level.sizeTop,
      };

      genSingleDigit() {
        Pos which = singleDigit[Pos.top] ? Pos.top : Pos.bottom;
        if (carryLast && carryNow) {
          result.digits[i] = 9;
          numbers[which].digits[i] = 9;
          return;
        }
        final lower =
            (lastDigit[which] ? 1 : 0) + (carryLast ? 1 : 0);
        final upper = 9;
        result.digits[i] = randIntInclusive(lower, upper);
        numbers[which].digits[i] =
            result.digits[i] - (carryLast ? 1 : 0);

        assert(i >= top.length ||
            (top.digits[i] >= 0 && top.digits[i] <= 9));
        assert(i >= bottom.length ||
            (bottom.digits[i] >= 0 && bottom.digits[i] <= 9));
        assert(!lastDigit[Pos.top] || top.digits[i] > 0);
        assert(!lastDigit[Pos.bottom] || bottom.digits[i] > 0);
      }

      genTwoDigitsAndCarry() {
        // Dos cifras en vertical seguro, arriba y abajo
        // Generar un resultado entre 10 y 18 (debe producir carry)
        final lower = 10;
        final upper = 18 + (carryLast ? 1 : 0);
        int sum = randIntInclusive(lower, upper);
        result.digits[i] = sum % 10;
        sum -= (carryLast ? 1 : 0);
        int start = sum - 9;
        if (start == 0) {
          if (lastDigit[Pos.top] && lastDigit[Pos.bottom]) {
            top.digits[i] = randIntInclusive(1, 8);
            bottom.digits[i] = sum - top.digits[i];
          } else if (lastDigit[Pos.top]) {
            top.digits[i] = randIntInclusive(1, 9);
            bottom.digits[i] = sum - top.digits[i];
          } else if (lastDigit[Pos.bottom]) {
            bottom.digits[i] = randIntInclusive(1, 9);
            top.digits[i] = sum - bottom.digits[i];
          } else {
            top.digits[i] = randIntInclusive(0, 9);
            bottom.digits[i] = sum - top.digits[i];
          }
        } else {
          top.digits[i] = randIntInclusive(start, 9);
          bottom.digits[i] = sum - top.digits[i];
        }
        assert(top.digits[i] >= 0 && top.digits[i] <= 9);
        assert(bottom.digits[i] >= 0 && bottom.digits[i] <= 9);
        assert(!lastDigit[Pos.top] || top.digits[i] > 0);
        assert(!lastDigit[Pos.bottom] || bottom.digits[i] > 0);
      }

      genTwoDigitsNoCarry() {
        // Generar un resultado entre lower y upper
        final lower = (carryLast ? 1 : 0) +
            (lastDigit[Pos.top] ? 1 : 0) +
            (lastDigit[Pos.bottom] ? 1 : 0);
        final upper = 9;
        int sum = randIntInclusive(lower, upper);
        result.digits[i] = sum;
        sum -= (carryLast ? 1 : 0);
        if (!lastDigit[Pos.top] && !lastDigit[Pos.bottom]) {
          int x = randIntInclusive(0, sum);
          top.digits[i] = x;
          bottom.digits[i] = sum - x;
        } else if (lastDigit[Pos.top] && lastDigit[Pos.bottom]) {
          assert(sum >= 2);
          int x = randIntInclusive(1, sum - 1);
          top.digits[i] = x;
          bottom.digits[i] = sum - x;
        } else {
          // last[UP] || last[DOWN]
          Pos which = (lastDigit[Pos.top] ? Pos.top : Pos.bottom);
          Pos other = (lastDigit[Pos.top] ? Pos.bottom : Pos.top);
          if (result.digits[i] == 1) {
            numbers[which].digits[i] = 1;
            numbers[other].digits[i] = 0;
          } else {
            int x = randIntInclusive(1, sum);
            numbers[which].digits[i] = x;
            numbers[other].digits[i] = sum - x;
          }
        }
        if (level.sizeTop > 1 &&
            level.sizeTop == level.sizeBottom &&
            i == level.sizeTop - 1) {
          assert(top.digits[i] > 0);
          assert(bottom.digits[i] > 0);
        }
        assert(top.digits[i] >= 0 && top.digits[i] <= 9);
        assert(bottom.digits[i] >= 0 && bottom.digits[i] <= 9);
        assert(!lastDigit[Pos.top] || top.digits[i] > 0);
        assert(!lastDigit[Pos.bottom] || bottom.digits[i] > 0);
      }

      // Solo queda una cifra arriba o abajo
      if (singleDigit[Pos.top] || singleDigit[Pos.bottom]) {
        genSingleDigit();
      } else if (carryNow) {
        genTwoDigitsAndCarry();
      } else {
        genTwoDigitsNoCarry();
      }
    }
    selfCheck();
  }
}

class LevelService {
  List<Level> get allLevels => [
        //Bloque 1: 1 suma, sin acarreo (Level 1 - 3)
        Level(1, 1, "_", [0]),
        Level(1, 2, "__", [1]),
        Level(2, 1, "__", [1]),
        //Bloque 2: 2 sumas, sin acarreo (Level 4 - 6)
        Level(2, 2, "__", [1]),
        Level(2, 3, "___", [2, 3, 4]),
        Level(3, 2, "___", [2, 3, 4]),
        //Bloque 3: 1 suma, 1 acarreo (Level 7 - 9)
        Level(1, 1, "c", [1]),
        Level(2, 1, "c_", [2, 3, 7]),
        Level(1, 2, "c_", [2, 3, 7]),
        //Bloque 4: 2 sumas, 1 acarreo (Level 10 - 17)
        Level(2, 2, "c_", [4, 8, 9]),
        Level(2, 3, "c__", [5, 6, 10]),
        Level(3, 2, "c__", [5, 6, 10]),
        Level(2, 2, "_c", [10]),
        Level(2, 3, "_c_", [11, 12, 13]),
        Level(3, 2, "_c_", [11, 12, 13]),
        Level(4, 2, "_c__", [14, 15]),
        Level(2, 4, "_c__", [14, 15]),
        //Bloque 5: 3 sumas, sin acarreo (Level 18 - 20)
        Level(3, 3, "___", [4, 5, 6]),
        Level(4, 3, "____", [4, 5, 6]),
        Level(3, 4, "____", [4, 5, 6]),
        //Bloque 6: 3 sumas, 1 acarreo (Level 21 - 29)
        Level(3, 3, "c__", [10, 18]),
        Level(4, 3, "c___", [19, 20, 21]),
        Level(3, 4, "c___", [19, 20, 21]),
        Level(3, 3, "_c_", [10, 18]),
        Level(4, 3, "_c__", [22, 23]),
        Level(3, 4, "_c__", [22, 23]),
        Level(3, 3, "__c", [13, 24]),
        Level(4, 3, "__c_", [25, 26]),
        Level(3, 4, "__c_", [25, 26]),
        //Bloque 7: 3 sumas, 2 acarreos (Level 30 - 41)
        Level(2, 2, "cc", [10, 13]),
        Level(2, 3, "cc_", [11, 12, 14, 15]),
        Level(3, 2, "cc_", [11, 12, 14, 15]),
        Level(3, 3, "c_c", [18, 21, 27]),
        Level(4, 3, "c_c_", [22, 23, 28, 29]),
        Level(3, 4, "c_c_", [22, 23, 28, 29]),
        Level(3, 3, "_cc", [18, 24, 27]),
        Level(4, 3, "_cc_", [31, 32]),
        Level(3, 4, "_cc_", [31, 32]),
        Level(4, 4, "cc__", [31, 32]),
        Level(4, 4, "c_c_", [31, 32]),
        Level(4, 4, "_cc_", [31, 32]),
        //Bloque 8: 3 sumas, 2 acarreos (Level 42 - 47)
        Level(3, 3, "ccc", [33, 36]),
        Level(4, 3, "ccc_", [37, 38]),
        Level(3, 4, "ccc_", [37, 38]),
        Level(4, 4, "_ccc", [42]),
        Level(4, 4, "c_cc", [39, 40, 41, 45]),
        Level(4, 4, "cc_c",
            [39, 40, 41, 45]), //carry del primer dígito al último
      ];

  Exercise generateExercise(int level) {
    LevelInstance instance = LevelInstance(allLevels[level]);
    instance._generateColumns();
    return Exercise(
      '${DateTime.now().toString()}',
      instance.top.digits,
      instance.bottom.digits,
      instance.result.digits,
    );
  }

  ExerciseSequence generateExerciseSequence(int level, { int count = 5 }) {
    ExerciseSequence sequence = ExerciseSequence();
    for (int i = 0; i < count; i++) {
      sequence.add(generateExercise(level));
    }
    return sequence;
  }
}
