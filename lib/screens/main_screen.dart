import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juego_sumas/model/levels.dart';
import 'package:juego_sumas/screens/exercise_screen.dart';
import 'package:juego_sumas/widgets/custom_buton.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const routeName = './';

  @override
  Widget build(BuildContext context) {
    final stages = Provider.of<LevelService>(context).allStages;
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: ListView.builder(
        itemCount: stages.length,
        itemBuilder: (ctx, stageIndex) {
          return StageWidget(stageIndex);
        },
      ),
    );
  }
}

class StageWidget extends StatelessWidget {
  final int stageIndex;
  StageWidget(this.stageIndex);

  @override
  Widget build(BuildContext context) {
    final allStages = Provider.of<LevelService>(context).allStages;
    final Stage stage = allStages[stageIndex];

    List<Widget> levelWidgets = [
      for (int i = 0; i < stage.numLevels; i++) 
        Align(
          alignment: Alignment(stage.getLevel(i).position.x, stage.getLevel(i).position.y),
          child: LevelWidget(i, stageIndex),
        ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      child: Container(
        color: Colors.amber[100 * stageIndex],
        height: LevelWidget.levelButtonSize * stage.height,
        child: Stack(children: levelWidgets),
      ),
    );
  }
}

class LevelWidget extends StatelessWidget {
  static const double levelButtonSize = 100;
  static const double _padding = 8;

  final int stageIndex, levelIndex;
  LevelWidget(this.levelIndex, this.stageIndex);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_padding),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ExerciseScreen.routeName,
            arguments: [stageIndex, levelIndex],
          );
        },
        child: CustomButton(
          height: levelButtonSize - 2 * _padding, // 2 * padding
          width: levelButtonSize - 2 * _padding, // 2 * padding
          color: Colors.blue[100 * stageIndex],
          isCircle: true,
          child: SvgPicture.asset(
            'assets/images/ic-medium.svg',
            fit: BoxFit.contain,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
