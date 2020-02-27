import 'package:cloud_firestore/cloud_firestore.dart';

class Log {
  String id;
  String levelId;
  DateTime startTime;
  DateTime endTime;

  Log({
    this.levelId,
    this.startTime,
    this.endTime,
  });

  Log.fromFirestore(DocumentSnapshot doc)
      : startTime = (doc.data['startTime'] as Timestamp).toDate(),
        endTime = (doc.data['endTime'] as Timestamp).toDate(),
        levelId = doc.data['levelId'];

  Map<String, dynamic> toFirestore() => {
        'levelid': levelId,
        'startTime': startTime,
        'endTime': endTime,
      };
}

List<Log> kidtoJason(QuerySnapshot query) {
  List<DocumentSnapshot> docs = query.documents;
  return docs.map((doc) => Log.fromFirestore(doc)).toList();
}
