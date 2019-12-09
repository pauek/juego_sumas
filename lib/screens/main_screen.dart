import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/levels.dart';

class MainScreen extends StatelessWidget {
  static const routeName = './';

  @override
  Widget build(BuildContext context) {
    final stages = Provider.of<LevelService>(context).allLevels;

    // orderLevels(stage) {
    //   var currentStage = stages[stage];
    //   var orderedLevels = new List();
    //   var deps = stages[stage][0].dependencies;
    //   var levelGroup = new List();

    //   currentStage.forEach((currentLevel) {
    //     // print(currentLevel.dependencies);
    //     // print(deps);
    //     if (listEquals(currentLevel.dependencies, deps)) {
    //       levelGroup.add(currentLevel);
    //       // print('equals');
    //     } else {
    //       deps = currentLevel.dependencies;
    //       orderedLevels.addAll(levelGroup);
    //       levelGroup = [currentLevel];
    //       // print('not equals');
    //     }
    //     // print(levelGroup.length);
    //     // print(' length: ${orderedLevels.length}');
    //   });

    //   // print(orderedLevels);
    //   return orderedLevels;
    // }


    return Scaffold(
      body: ListView.builder(
          itemCount: stages.length,
          itemBuilder: (ctx, stage) {

            // Container(
            //   height: stages[stage].length * 110.0,
            //   width: double.infinity,
            //   child: ListView.builder(
            //       physics: NeverScrollableScrollPhysics(),
            //       itemCount: stages[stage].length,
            //       itemBuilder: (ctx, level) {
            // return getDependencies(stage);

            return Container(
              height: stages[stage].length * 110.0,
              width: double.infinity,
              margin: EdgeInsets.only(top: 5),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: stages[stage].length,
                  itemBuilder: (ctx, sameDeps) {
                    // return Text(stages[stage][sameDeps].length.toString());
                    return Container(
                      alignment: Alignment.center,
                      height: 110,
                      width: stages[stage][sameDeps].length * 105.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: stages[stage][sameDeps].length,
                        itemBuilder: (ctx, level) {
                          // return Text(stages[stage][sameDeps].length.toString());
                          return Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: FlatButton(
                                child: Text(
                                    'stage: ${stages[stage][sameDeps][level].stage} deps: ${stages[stage][sameDeps][level].dependencies}'),
                                // 'stage: $stage deps: ${orderedLevels[l][element].dependencies}'),
                                // 'text'),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    './operation',
                                    arguments: stage,
                                  );
                                },
                                color: Colors.blue[100 * stage],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
            );

            // return Row(
            //   // alignment: Alignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Container(
            //       height: 100,
            //       width: 100,
            //       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            //       // color: Colors.green[200],
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(50),
            //         child: FlatButton(
            //           child: Text(
            //               'stage: $stage deps: ${stages[stage][level].dependencies}'),
            //           onPressed: () {
            //             Navigator.of(context).pushNamed(
            //               './operation',
            //               arguments: stage,
            //             );
            //           },
            //           color: Colors.blue[100 * stage],
            //         ),
            //       ),
            //     ),
            //   ],
            // );
            //       }),
            // ),
          }),
    );
  }
}
