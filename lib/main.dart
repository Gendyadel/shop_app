import 'package:flutter/material.dart';
import 'package:shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/service/network/dio_helper.dart';
import 'package:shop_app/service/storage/cache_helper.dart';
import 'package:shop_app/src/app_root.dart';
import 'package:shop_app/src/constants.dart';
import 'package:shop_app/views/layout/shop_layout.dart';
import 'package:shop_app/views/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print('token: $token');
  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(
    AppRoot(
      isDark: isDark,
      startWidget: widget,
    ),
  );
}
