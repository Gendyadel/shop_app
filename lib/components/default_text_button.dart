import 'package:flutter/material.dart';

Widget defaultTextButton({@required onPressed, @required String text}) => TextButton(
      onPressed: onPressed,
      child: Text(
        '${text.toUpperCase()}',
      ),
    );
