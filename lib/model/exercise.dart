import 'dart:math';

List<int> maxedInt(List<int> L, int len) {
  List<int> res = [...L];
  while (res.length < len) {
    res.add(null);
  }
  return res;
}

List<bool> maxedBool(List<bool> L, int len) {
  List<bool> res = [...L];
  while (res.length < len) {
    res.add(false);
  }
  return res;
}

class Exercise {
  final String id;
  final List<int> top;
  final List<int> bottom;
  final List<int> result;
  final List<bool> carry;

  Exercise(
    this.id,
    this.top,
    this.bottom,
    this.result,
    this.carry,
  );

  get maxLength {
    var maxDigits = max(top.length, (bottom.length));
    return max(maxDigits, result.length);
  }

  get maxedTop => maxedInt(top, maxLength);
  get maxedBottom => maxedInt(bottom, maxLength);
  get maxedResult => maxedInt(result, maxLength);
  get maxedCarry => maxedBool(carry, maxLength);
}
