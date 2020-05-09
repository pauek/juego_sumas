import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Widget child;
  final bool isCircle;

  CustomButton({
    this.height,
    this.width,
    this.color,
    this.child,
    this.isCircle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: height ,
        width: width,
        decoration: BoxDecoration(
          color: color,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : BorderRadius.circular(50),
          border: Border.all(
            color: Colors.black12,
            width: 3,
          ),
        ),
        padding: isCircle ? EdgeInsets.all(17) : EdgeInsets.all(5),
        // margin: EdgeInsets.symmetric(
        //   horizontal: 5,
        //   vertical: 5,
        // ),
        child: child,
      ),
    );
  }
}
