import 'package:shared_preferences/shared_preferences.dart';
import 'package:juego_sumas/database/database.dart' as db;

class UserManager {
  static Future startFirstTime(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('firstTime');

    if (firstTime == null || !firstTime) {
      prefs.setBool("firstTime", true);
      String kidId = await db.createUser();
      prefs.setString("kidId", kidId);
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
