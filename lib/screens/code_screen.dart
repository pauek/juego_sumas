import 'package:flutter/material.dart';
import 'package:juego_sumas/utils/UserManager.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CodeScreen extends StatelessWidget {
  static const routeName = './codeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          QrImage(
            data: UserManager.kidId,
            version: QrVersions.auto,
            // size: 500,
            // gapless: false,
            // foregroundColor: Colors.white,
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue[200],
            ),
            child: Text(
              "Para poder acceder, pide a un mayor que escanee el codigo!",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
