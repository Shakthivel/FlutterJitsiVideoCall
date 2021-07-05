import 'package:flutter/material.dart';
import 'package:zoom_clone/constants/colors.dart';
import 'package:zoom_clone/constants/styles.dart';

Widget dividerOrWidget = Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(40, 20, 15, 10),
        height: 1.5,
        color: Colors.grey,
      ),
    ),
    Text(
      "or",
      style: TextStyle(fontSize: 18),
    ),
    Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 20, 40, 10),
        height: 1.5,
        color: Colors.grey,
      ),
    ),
  ],
);

Widget colorButton({String buttonText}) {
  return Container(
    margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: appPurple,
    ),
    padding: EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 40,
    ),
    child: Center(
      child: Text(
        buttonText,
        style: buttonStyle,
      ),
    ),
  );
}

Widget whiteButton({String buttonText}) {
  return Container(
    margin: EdgeInsets.only(top: 15, bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(color: Colors.grey[600]),
    ),
    padding: EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 40,
    ),
    child: Text(
      buttonText,
      style: TextStyle(
        color: Colors.grey[600],
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  );
}

Widget authDecoratedBox({Widget childWidget}) {
  return Container(
    decoration: BoxDecoration(
      color: appPurple,
    ),
    width: double.infinity,
    child: childWidget,
  );
}
