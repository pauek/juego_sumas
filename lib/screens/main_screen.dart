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
          height: stages[stage].length * 110.0,
          width: double.infinity,
          child: ListView.builder(
            // shrinkWrap: true,
            //  physics: ScrollPhysics(),
            physics: NeverScrollableScrollPhysics(),
            itemCount: stages[stage].length,
            itemBuilder: (ctx, level) => Align(
              alignment: Alignment.center,
              child: Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                // color: Colors.green[200],
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
          ),
        ),
      ),
    );
  }
}
