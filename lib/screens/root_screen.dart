import 'package:flutter/material.dart';
import 'package:juego_sumas/screens/code_screen.dart';
import 'package:juego_sumas/utils/UserManager.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootScreenState extends State<RootScreen> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    initAuthStatus();
  }

  initAuthStatus() async {
    authStatus = (await UserManager.getKidParent()) != null
        ? AuthStatus.signedIn
        : AuthStatus.notSignedIn;

    var kidId = await UserManager.getKidId();

    switch (authStatus) {
      case AuthStatus.notSignedIn:
        //Show qr screen
        Navigator.of(context).pushReplacementNamed(CodeScreen.routeName);
        if (kidId == null || kidId == '') {
          UserManager.startFirstTime(context);
        }
        break;
      case AuthStatus.signedIn:
        //show main screen  
        // Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}
