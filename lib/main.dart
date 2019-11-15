import 'package:flutter/material.dart';
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
        title: 'Juego sumas',
        home: MainScreen(),
        routes: {
          ExerciseScreen.routeName: (ctx) => ExerciseScreen(),
          MainScreen.routeName: (ctx) => MainScreen(),
        },
      ),
    );
  }
}
