import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juego_sumas/model/log.dart';
import 'package:juego_sumas/utils/UserManager.dart';

class DataBase {
  static final firestore = Firestore.instance;
  static Future<void> sendLog(String kidId, Log log) async {
    await firestore.collection('kids/$kidId/logs').add(log.toFirestore());
  }

  static Future<String> createUser() async {
    DocumentReference kidRef = firestore.collection("kids").document();

    // Kid kid = new Kid(createdAt: DateTime.now());
    await kidRef.setData({
      "createdAt": DateTime.now(),
    });
    return kidRef.documentID;
  }

  static Future<dynamic> isRegistred() async {
    var res = firestore
        .collection("kids")
        .document(UserManager.kidId)
        .snapshots();
    print(res);
    return res;
  }
}
