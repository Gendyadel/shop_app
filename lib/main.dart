import 'package:flutter/material.dart';
import 'package:shop_app/service/network/dio_helper.dart';
import 'package:shop_app/service/storage/cache_helper.dart';
import 'package:shop_app/src/app_root.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getBool(key: 'isDark');

  runApp(AppRoot(isDark));
}



