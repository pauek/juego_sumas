import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/levels.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatelessWidget {
  static const routeName = './';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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
      // backgroundColor: Colors.amber[100],
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/pattern-02.png"),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(Colors.black87, BlendMode.screen),
        //   ),
        // ),
        child: ListView.builder(
            itemCount: stages.length,
            itemBuilder: (ctx, stage) {
              return Container(
                alignment: Alignment.center,
                height: stages[stage].length * 110.0,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: stages[stage].length,
                      itemBuilder: (ctx, sameDeps) {
                        // return Text(stages[stage][sameDeps].length.toString());
                        return Center(
                          child: Container(
                            // alignment: Alignment.center,
                            height: 110,
                            width: stages[stage][sameDeps].length * 135.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: stages[stage][sameDeps].length,
                              itemBuilder: (ctx, level) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      './operation',
                                      arguments: stage,
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100 * stage],
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 3,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(15),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/ic-medium.svg',
                                        fit: BoxFit.contain,
                                        color: Colors.white70,
                                        // child: Text(
                                        // 'stage: ${stages[stage][sameDeps][level].sizeTop} deps: ${stages[stage][sameDeps][level].dependencies}'),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                ),
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
      ),
    );
  }
}
