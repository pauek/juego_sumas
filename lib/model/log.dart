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
  //TODO: save color

  Log({
    this.levelIndex,
    this.stageIndex,
    this.startTime,
    this.endTime,
    this.nextGroup,
    this.didWin,
    this.mistakes,
  });

  Log.fromFirestore(DocumentSnapshot doc)
      : startTime = (doc.data['startTime'] as Timestamp).toDate(),
        endTime = (doc.data['endTime'] as Timestamp).toDate(),
        levelIndex = doc.data['levelIndex'],
        stageIndex = doc.data['stageIndex'],
        nextGroup = doc.data['nextGroup'],
        didWin = doc.data['didWin'],
        mistakes = doc.data['mistakes'];

  Map<String, dynamic> toFirestore() => {
        'levelIndex': levelIndex,
        'stageIndex': stageIndex,
        'startTime': startTime,
        'endTime': endTime,
        'nextGroup': nextGroup,
        'didWin': didWin,
        'mistakes': mistakes,
      };
}

List<Log> kidtoJason(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.documents;
  return docs.map((doc) => Log.fromFirestore(doc)).toList();
}
