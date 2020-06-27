import 'package:flutter/material.dart';
import 'package:juego_sumas/utils/UserManager.dart';
import 'package:juego_sumas/utils/style.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CodeScreen extends StatelessWidget {
  static const routeName = './codeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Expanded(
              child: Center(
                child: QrImage(
                  data: UserManager.kidId,
                  version: QrVersions.auto,
                  // size: 500,
                  // gapless: false,
                  // foregroundColor: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  // padding: EdgeInsets.all(20),
                  // margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.blue[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Style.body(
                        "Para poder acceder, pide a un mayor que escanee el codigo!",
                        color: Colors.white,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
