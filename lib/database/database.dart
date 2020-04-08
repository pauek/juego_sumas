import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juego_sumas/model/log.dart';

Future<void> sendLog(String kidId, Log log) async {
  await Firestore.instance
      .collection('kids/$kidId/logs')
      .add(log.toFirestore());
}

Future<String> createUser() async {
  DocumentReference kidRef = Firestore.instance.collection("kids").document();
  await kidRef.setData({
    "createdAt": DateTime.now(),
  });
  return kidRef.documentID;
}
