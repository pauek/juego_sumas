import 'package:flutter/material.dart';

class Style {

  //Texts
  static Widget title(
    text, {
    color,
    maxLines,
    textAlign,
    double fontSize,
    height,
  }) {
    return Text(
      text != null ? text : '',
      maxLines: maxLines,
      textAlign: textAlign != null ? textAlign : TextAlign.left,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
          fontFamily: 'Baloo',
          height: height,
          color: color == null ? Colors.black : color,
          fontSize: fontSize == null ? 22 : fontSize,
          fontWeight: FontWeight.bold),
    );
  }

  static Widget body(
    text, {
    color,
    maxLines,
    textAlign,
    double fontSize,
    height,
  }) {
    return Text(
      text != null ? text : '',
      maxLines: maxLines,
      textAlign: textAlign != null ? textAlign : TextAlign.left,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
          fontFamily: 'Baloo',
          height: height,
          color: color == null ? Colors.black : color,
          fontSize: fontSize == null ? 18 : fontSize),
    );
  }

  //Buttons
  static Widget button(
    text,
    onPressed, {
    height,
    width,
    color,
  }) {
    return FlatButton(
      splashColor: Colors.black12,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
            color: Colors.black12,
            width: 4,
            style: BorderStyle.solid,
          )),
      color: color,
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Transform.rotate(
            angle: 45,
            child: Container(
              margin: EdgeInsets.all(2),
              width: 40,
              height: 40,
              // decoration: BoxDecoration(
              //   // color: Colors.black,
              //   // borderRadius: BorderRadius.circular(50),
              //   shape: BoxShape.circle,
              //   border: Border(
              //       right: BorderSide(style: BorderStyle.none),
              //       top: BorderSide(style: BorderStyle.none),
              //       bottom: BorderSide(style: BorderStyle.none),
              //       left: BorderSide(
              //           color: Colors.black12,
              //           width: 5,
              //           style: BorderStyle.solid)),
              // ),
            ),
          ),
          title(text, color: Colors.black26, textAlign: TextAlign.center),
          Transform.rotate(
            angle: 45,
            child: Container(
              margin: EdgeInsets.all(2),
              width: 40,
              height: 40,
              // decoration: BoxDecoration(
              //     // color: Colors.black,
              //     // borderRadius: BorderRadius.circular(50),
              //     border: Border(
              //         right: BorderSide(
              //             color: Colors.black12,
              //             width: 5,
              //             style: BorderStyle.solid))),
            ),
          ),
        ],
      ),
    );
  }
}
