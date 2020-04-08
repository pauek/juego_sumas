import 'dart:async';

import 'package:flutter/material.dart';
import 'package:juego_sumas/screens/main_screen.dart';
import 'package:fluttie/fluttie.dart';

class WinScreen extends StatefulWidget {
  static const routeName = './winScreen';

  @override
  _WinScreenState createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  FluttieAnimationController winAnimation;
  var instance = Fluttie();

  bool ready = false;

  prepareAnimations() async {
    bool canBeUsed = await Fluttie.isAvailable();
    if (!canBeUsed) {
      print("Animations are not supported on this platform");
      return;
    }

    var animation = await instance
        .loadAnimationFromAsset("assets/animations/win_animation.json");

    winAnimation = await instance.prepareAnimation(
      animation,
      duration: const Duration(seconds: 3),
      repeatCount: const RepeatCount.infinite(),
      repeatMode: RepeatMode.START_OVER,
    );

    if (mounted) {
      setState(() {
        ready = true;
        winAnimation.start();
      });
    }
  }

  // @override
  // void initState() {
  //   Timer(Duration(seconds: 3),
  //       // () => Navigator.of(context).pushNamed(MainScreen.routeName));
  //   super.initState();
  //   prepareAnimations();
  // }

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
                    height: 500,
                    width: 500,
                    child: FluttieAnimation(winAnimation))),
            // Text("You win!"),
          ]),
    );
  }
}
