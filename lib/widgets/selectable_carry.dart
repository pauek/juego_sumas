import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class SelectableCarry extends StatefulWidget {
  @override
  _SelectableCarryState createState() => _SelectableCarryState();
}

class _SelectableCarryState extends State<SelectableCarry> {
  bool carry = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          carry = !carry;
        });
      },
      child: Align(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          width: 42,
          height: 42,
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(
              color: (carry ? Colors.orange : Colors.black12),
              width: 2,
            ),
            color: (carry ? Colors.orange[100] : Colors.white),
          ),
          child: Center(
            child: Text(
              (carry ? '1' : ''),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors.orange[900],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
