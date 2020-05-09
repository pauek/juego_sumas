import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          SvgPicture.asset(
            'assets/images/ic-hard.svg',
            color: Colors.black12,
            // fit: BoxFit.cover,
          ),
          title(text, color: Colors.black26, textAlign: TextAlign.center),
          SvgPicture.asset(
            'assets/images/ic-hard.svg',
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}
