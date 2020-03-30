import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juego_sumas/model/log.dart';
import 'package:juego_sumas/utils/UserManager.dart';

Future<void> sendLog(String kidId, Log log) async {
  await Firestore.instance
      .collection('kids/$kidId/logs')
      .add(log.toFirestore());
}

Future<void> addLogsCollection() async {
  String kidId = await UserManager.getKidId();

  // await Firestore.instance.collection('kid/$kidId').add();

}

Future<String> createUser() async {
 DocumentReference kid =  await Firestore.instance.collection("kids").add({
    "name": "",
    "createdAt": DateTime.now(), 
    'parent': ""
  }); 

  //todo: add logs collection 



  return kid.documentID;
}
