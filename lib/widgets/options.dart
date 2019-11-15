import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:juego_sumas/model/exercise_sequence.dart';

class Options extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final updateResult = Provider.of<ExerciseSequence>(context);
    int index = 1;

    void handleResult(int value) {
      if(index == 0) index++;
      else  if(index == 1) index--;
      updateResult.addDigit(value);
    }

    return GridView.count(
      crossAxisCount: 5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 7,
      children: List.generate(10, (index) {
        return Container(
          height: 50,
          width: 60,
          child: FlatButton(
            shape: StadiumBorder(),
            color: Colors.blue[200],
            textColor: Colors.white,
            onPressed: () {
              handleResult(index);
              // updateResult.insertResult(exId, index, 0);
            },
            child: Text(
              '$index',
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      }),
    );
  }
}
