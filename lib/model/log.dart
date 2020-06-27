import 'package:cloud_firestore/cloud_firestore.dart';

class Log {
  String id;
  int levelIndex;
  int stageIndex;
  DateTime startTime;
  DateTime endTime;
  String nextGroup;
  bool didWin;
  int mistakes;
  int topNumbers;
  int bottomNumbers;
  String color;

  Log(
      {this.levelIndex,
      this.stageIndex,
      this.startTime,
      this.endTime,
      this.nextGroup,
      this.didWin,
      this.mistakes,
      this.topNumbers,
      this.bottomNumbers,
      this.color});

  Log.fromFirestore(DocumentSnapshot doc)
      : startTime = (doc.data['startTime'] as Timestamp).toDate(),
        endTime = (doc.data['endTime'] as Timestamp).toDate(),
        levelIndex = doc.data['levelIndex'],
        stageIndex = doc.data['stageIndex'],
        nextGroup = doc.data['nextGroup'],
        didWin = doc.data['didWin'],
        mistakes = doc.data['mistakes'],
        topNumbers = doc.data['topNumbers'],
        bottomNumbers = doc.data['bottomNumbers'],
        color = doc.data['color'];

  Map<String, dynamic> toFirestore() => {
        'levelIndex': levelIndex,
        'stageIndex': stageIndex,
        'startTime': startTime,
        'endTime': endTime,
        'nextGroup': nextGroup,
        'didWin': didWin,
        'mistakes': mistakes,
        'topNumbers': topNumbers,
        'bottomNumbers': bottomNumbers,
        'color': color,
      };
}

