import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:juego_sumas/model/levels.dart';
import 'package:juego_sumas/pages/exersice/exercise_page.dart';
import 'package:juego_sumas/utils/UserManager.dart';
import 'package:juego_sumas/widgets/custom_buton.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  static const routeName = "/";
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userId = UserManager.kidId;
  }

  @override
  Widget build(BuildContext context) {
    final stages = Provider.of<LevelService>(context).allStages;
    return Scaffold(
      // backgroundColor: Colors.amber[100],
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
          alignment: Alignment(
              stage.getLevel(i).position.x, stage.getLevel(i).position.y),
          child: LevelWidget(i, stageIndex),
        ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        // color: Colors.amber[100 * stageIndex],
        height: MediaQuery.of(context).size.width * 0.3 * stage.height,
        child: Stack(children: levelWidgets),
      ),
    );
  }
}

class LevelWidget extends StatelessWidget {
  static const double levelButtonSize = 120;
  static const double _padding = 8;

  final int stageIndex, levelIndex;
  LevelWidget(this.levelIndex, this.stageIndex);

  Widget getImage(int type) {
    String src;
    double rotate;
    switch (type) {
      case 0:
        src = 'assets/images/ic-simple.svg';
        rotate = 0;
        break;
      case 1:
        src = 'assets/images/ic-medium.svg';
        rotate = -3.14 / 2;
        break;
      case 2:
        src = 'assets/images/ic-medium.svg';
        rotate = 0;
        break;
      case 3:
        src = 'assets/images/ic-hard.svg';
        rotate = 0;
        break;
    }

    return Transform.rotate(
      angle: rotate,
      child: SvgPicture.asset(
        src,
        fit: BoxFit.contain,
        color: Colors.white70,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.3;
    final int levelImage = Provider.of<LevelService>(context)
        .getLevelImage(stageIndex, levelIndex);
    final bgColor = Provider.of<LevelService>(context).getColor(stageIndex);
    final groupId =
        Provider.of<LevelService>(context).getGroupId(stageIndex, levelIndex);
    return StreamBuilder(
      stream: Firestore.instance
          .collection("kids")
          .document(UserManager.kidId)
          .collection('logs')
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          bool isActive;

          groupId == 'group1'
              ? isActive = true
              : isActive = snapshot.data.documents
                  .any((doc) => doc.data['nextGroup'] == groupId);

          //TODO: Delete this!
          // isActive = true;

          return Padding(
            padding: const EdgeInsets.all(_padding),
            child: GestureDetector(
              onTap: isActive != null && isActive
                  ? () {
                    print(stageIndex);
                      Navigator.of(context).pushNamed(
                        ExercisePage.routeName,
                        arguments: [stageIndex, levelIndex],
                      );
                    }
                  : null,
              child: CustomButton(
                height: size - 2 * _padding, // 2 * padding
                width: size - 2 * _padding, // 2 * padding
                color:
                    isActive != null && isActive ? bgColor : Colors.grey[200],
                isCircle: true,
                child: getImage(levelImage),
                isDisabled: isActive != null ? !isActive : true,
              ),
            ),
          );
        }
        return CustomButton(
          height: size - 2 * _padding, // 2 * padding
          width: size - 2 * _padding, // 2 * padding
          color: Colors.grey[200],
          isCircle: true,
          child: getImage(levelImage),
          isDisabled: true,
        );
      },
    );
  }
}
