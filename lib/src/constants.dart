import 'package:flutter/material.dart';
import 'package:shop_app/service/storage/cache_helper.dart';
import 'package:shop_app/views/login_screen.dart';

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndReplace(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder:(context)=> widget), (route) => false);

void signOut (context){

  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndReplace(context, LoginScreen());
    }
  });
}

String token='';