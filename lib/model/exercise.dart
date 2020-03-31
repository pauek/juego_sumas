import 'dart:math';

List<int> maxed(List<int> L, int len) {
  List<int> res = [...L];
  while (res.length < len) {
    res.add(null);
  }
  return res;
}

class Exercise {
  final String id;
  final List<int> top;
  final List<int> bottom;
  final List<int> result;

  Exercise(
    this.id,
    this.top,
    this.bottom,
    this.result,
  );

  get maxLength => max(top.length, bottom.length);
  get maxedTop => maxed(top, maxLength);
  get maxedBottom => maxed(bottom, maxLength);
}
