import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:juego_sumas/database/database.dart' as db;

class UserManager {
  static String kidId;

  /*
  static Future startFirstTime(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('firstTime');

    if (firstTime == null || !firstTime) {
      await prefs.setBool("firstTime", true);
      final String kidId = await db.createUser();
      await prefs.setString("kidId", kidId);
      return kidId;
    }
  }
  */

  static Future<void> loadKidId() async {
    // 1. Si ja el sabem, no cal fer res
    if (kidId == null) {
      // 2. Encara no el sabem, anem a mirar si està a SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      kidId = prefs.getString('kidId');

      // 3. Si allà no hi és, demanem un object nou a Firestore
      if (kidId == null) {
        kidId = await db.createUser();
        await prefs.setString("kidId", kidId);
      }
    }
    print("Kid Id = $kidId");
  }

  static Stream<DocumentSnapshot> kidSnapshots() async* {}
}
