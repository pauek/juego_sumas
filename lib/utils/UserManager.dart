import 'package:shared_preferences/shared_preferences.dart';
import 'package:juego_sumas/database/database.dart' as db;
import 'package:uuid/uuid.dart';

class UserManager {
  var uuid = new Uuid();

  static Future startFirstTime(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('firstTime');

    if (firstTime == null || !firstTime) {
      await prefs.setBool("firstTime", true);
      // TODO: generate UUID
      // String kidId = uuid.v4().toString();
      var kidId;

      // String kidId = await db.createUser();
      await prefs.setString("kidId", kidId);
      return kidId;
    }
  }

  static Future<String> getKidId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('kidId');
  }

  static Future<String> getKidParent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('parent');
  }
}
