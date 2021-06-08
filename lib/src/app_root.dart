import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/app_cubit.dart';
import 'package:shop_app/src/themes.dart';

class AppRoot extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  AppRoot({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, states) {},
        builder: (context, states) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
