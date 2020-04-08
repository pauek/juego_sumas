import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juego_sumas/model/log.dart';
import 'package:juego_sumas/utils/UserManager.dart';

Future<void> sendLog(String kidId, Log log) async {
  await Firestore.instance
      .collection('kids/$kidId/logs')
      .add(log.toFirestore());
}

Future<String> createUser() async {
  var response = Firestore.instance
      .collection("kids")
      .document('documentId')
      .setData({"name": "", "createdAt": DateTime.now(), 'parent': ""});
      
  print(response);
}
