import 'package:flutter/material.dart';
import 'package:juego_sumas/screens/code_screen.dart';
import 'package:juego_sumas/screens/root_screen.dart';
import 'package:juego_sumas/screens/win_screen.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/levels.dart';
import 'package:juego_sumas/screens/main_screen.dart';
import 'package:juego_sumas/screens/exercise_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LevelService>.value(value: LevelService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Juego sumas',
        home: RootScreen(),
        routes: {
          ExerciseScreen.routeName: (ctx) => ExerciseScreen(),
          MainScreen.routeName: (ctx) => MainScreen(),
          WinScreen.routeName: (ctx) => WinScreen(),
          CodeScreen.routeName: (ctx) => CodeScreen(),
        },
      ),
    );
  }
}
