import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/levels.dart';

class MainScreen extends StatelessWidget {
  static const routeName = './';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final levels = Provider.of<LevelService>(context).allLevels;
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          width: mediaQuery.size.width * 0.45,
          child: ListView.builder(
            itemCount: levels.length,
            itemBuilder: (ctx, level) => Container(
              height: 150,
              width: 95,
              margin: EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: FlatButton(
                  child: Text('$level'),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      './operation',
                      arguments: level,
                    );
                  },
                  color: Colors.blue[200],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
