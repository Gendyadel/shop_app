import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/app_cubit.dart';
import 'package:shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/src/themes.dart';

class AppRoot extends StatelessWidget {

  final bool isDark;

  AppRoot(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()
          ..changeAppMode(
            fromShared: isDark,
          ) ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, states) {},
        builder: (context, states) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
