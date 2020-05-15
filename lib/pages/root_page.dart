import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:juego_sumas/pages/code_screen.dart';
import 'package:juego_sumas/pages/main/main_page.dart';
import 'package:juego_sumas/utils/UserManager.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  //TODO: create splash screen
  Widget _splash() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            "assets/images/bg_splash1.png",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.amber[200],
              borderRadius: BorderRadius.circular(100)),
          // child: Style.title('Logo'),
        ),
      ],
    );
  }

  void goToMainPage() async {
    Navigator.of(context).pushReplacementNamed(MainPage.routeName);
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
                    return MainPage();

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
