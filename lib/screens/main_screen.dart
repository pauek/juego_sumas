import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/levels.dart';

class MainScreen extends StatelessWidget {
  static const routeName = './';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final stages = Provider.of<LevelService>(context).allLevels;
    return Scaffold(
      body: ListView.builder(
        itemCount: stages.length,
        itemBuilder: (ctx, stage) => Container(
          height: 150,
          width: 150,
          //  constraints: BoxConstraints.expand(width: 50.0, height: 100.0),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              ListView.builder(
                itemCount: stages[stage].length,
                itemBuilder: (ctx, level) => Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  // color: Colors.blue[100 * stage],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FlatButton(
                      child: Text('stage: $stage level: $level'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          './operation',
                          arguments: stage,
                        );
                      },
                      color: Colors.blue[100 * stage],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
