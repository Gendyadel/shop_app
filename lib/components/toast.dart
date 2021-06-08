import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToaster(
        {@required String message,
        @required ToastStates state,
         Color textColor = Colors.white,}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: textColor,
      fontSize: 16.0,
    );

enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;

      break;
  }
  return color;
}