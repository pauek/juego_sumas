import 'package:flutter/material.dart';
import 'package:juego_sumas/pages/code_screen.dart';
import 'package:juego_sumas/pages/exersice/exercise_page.dart';
import 'package:juego_sumas/pages/root_page.dart';
import 'package:juego_sumas/pages/win_screen.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/levels.dart';

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
        theme: ThemeData(fontFamily: 'Baloo'),
        home: RootPage(),
        routes: {
          ExercisePage.routeName: (ctx) => ExercisePage(),
          // MainScreen.routeName: (ctx) => MainScreen(),
          WinScreen.routeName: (ctx) => WinScreen(),
          CodeScreen.routeName: (ctx) => CodeScreen(),
        },
      ),
    );
  }
}
