import 'dart:async';

import 'package:flutter/material.dart';
import 'package:juego_sumas/utils/style.dart';
import 'package:lottie/lottie.dart';

class WinScreen extends StatefulWidget {
  static const routeName = './winScreen';
  final bool didWin;

  WinScreen({this.didWin});

  @override
  _WinScreenState createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> with TickerProviderStateMixin {
  AnimationController _controller;

  String rewardText = '';

  // if (widget.didWin) {
  //   text = "¡Bien hecho! Has superado el nivel";
  // } else {
  //   text = "No has superado el nivel, intantalo de nuevo";
  // }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.of(context).popUntil((r) => r.isFirst));
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Container(
                    height: 450,
                    width: 600,
                    child: Lottie.asset(
                      widget.didWin
                          ? "assets/animations/win_animation1.json"
                          : "assets/animations/lose_animation1.json",
                          repeat: false,
                      // controller: _controller,
                      // onLoaded: (composition) {
                      //   _controller.duration = composition.duration;
                      //   _controller.stop();
                      // },
                    ))),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Style.body(
                  widget.didWin
                      ? '¡Bien hecho! Has superado el nivel'
                      : 'No has superado el nivel, intantalo de nuevo',
                  fontSize: 22, textAlign: TextAlign.center),
            ),
          ]),
    );
  }
}
