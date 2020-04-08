import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:juego_sumas/screens/code_screen.dart';
import 'package:juego_sumas/screens/main_screen.dart';
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
  // AuthStatus authStatus = AuthStatus.notSignedIn;

  /*

  @override
  void initState() {
    super.initState();
    initAuthStatus();
  }

  initAuthStatus() async {
    authStatus = (await UserManager.getKidParent()) != null
        ? AuthStatus.signedIn
        : AuthStatus.notSignedIn;

    await UserManager.startFirstTime(context);

    switch (authStatus) {
      case AuthStatus.notSignedIn:
        // Show qr screen
        Navigator.of(context).pushReplacementNamed(CodeScreen.routeName);
        break;
      case AuthStatus.signedIn:
        //show main screen
        // Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
        break;
      default:
        break;
    }
  }
  */

  Widget _splash() {
    return Container(
      color: Colors.blue,
    );
  }

  void goToMainScreen() async {
    Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: UserManager.loadKidId(),
      builder: (context, AsyncSnapshot kidIdSnashot) {
        switch (kidIdSnashot.connectionState) {
          case ConnectionState.done:
            return StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('kids')
                  .document(UserManager.kidId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    child: Center(
                      child: Text(snapshot.error.toString()),
                    ),
                  );
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                    final bool hasParent = snapshot.data.data['parent'] != null;
                    if (!hasParent) {
                      return CodeScreen();
                    }
                    return MainScreen();

                  case ConnectionState.done:
                    return Placeholder();

                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return _splash();
                }
              },
            );

          default:
            return _splash();
        }
      },
    );
  }
}
