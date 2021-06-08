import 'package:flutter/material.dart';

Widget separatorDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 15.0,
        end: 15.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
