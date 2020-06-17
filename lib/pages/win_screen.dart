import 'dart:async';

import 'package:flutter/material.dart';
import 'package:juego_sumas/pages/main/main_page.dart';
import 'package:fluttie/fluttie.dart';
import 'package:juego_sumas/utils/style.dart';

class WinScreen extends StatefulWidget {
  static const routeName = './winScreen';
  final bool didWin;

  WinScreen({this.didWin});

  @override
  _WinScreenState createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  FluttieAnimationController winAnimation;
  var instance = Fluttie();

  bool ready = false;
  String rewardText = ''; 

  prepareAnimations() async {
    bool canBeUsed = await Fluttie.isAvailable();
    String text; 
    if (!canBeUsed) {
      print("Animations are not supported on this platform");
      return;
    }
    var animation;
    if (widget.didWin) {
      animation = await instance
          .loadAnimationFromAsset("assets/animations/win_animation1.json");
          text = "¡Bien hecho! Has superado el nivel"; 
    } else {
      animation  = await instance
        .loadAnimationFromAsset("assets/animations/lose_animation1.json");
        text = "No has superado el nivel, intantalo de nuevo"; 
    }

    winAnimation = await instance.prepareAnimation(
      animation,
      duration: const Duration(seconds: 3),
      // repeatCount: const RepeatCount.infinite(),
      repeatMode: RepeatMode.START_OVER,
    );

    if (mounted) {
      setState(() {
        rewardText = text;
        ready = true;
        winAnimation.start();
      });
    }
  }

  @override
  void initState() {
    Timer(Duration(seconds: 3),
        () => Navigator.of(context).popUntil((r) => r.isFirst));
    super.initState();
    prepareAnimations();
  }

  @override
  dispose() {
    super.dispose();
    winAnimation?.dispose();
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
                    child: FluttieAnimation(winAnimation))),
            Style.body(rewardText, fontSize: 22),
          ]),
    );
  }
}
