import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/service/network/dio_helper.dart';
import 'package:shop_app/service/network/end_point.dart';
import 'package:shop_app/src/constants.dart';
import 'package:shop_app/views/categories_screen.dart';
import 'package:shop_app/views/favourites_screen.dart';
import 'package:shop_app/views/products_screen.dart';
import 'package:shop_app/views/settings_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel homeModel;

  void getHomeData() {
    emit(LoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //print(_homeModel.data.banners[0].image);
      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      print(favorites.toString());
      emit(SuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      //print(_homeModel.data.banners[0].image);
      emit(SuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCategoriesDataState());
    });
  }

  Map<int, bool> favorites = {};

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(SuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((onError) {
      emit(ErrorChangeFavoritesState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    emit(LoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //print(_homeModel.data.banners[0].image);
      emit(SuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetFavoritesState());
    });
  }

  LoginModel userModel;

  void getUserData() {
    emit(LoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      //print(_homeModel.data.banners[0].image);
      emit(SuccessGetUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetUserDataState());
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(LoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': '$name',
        'email': '$email',
        'phone': '$phone',
      },
    ).then((value) {
      print('here');
      userModel = LoginModel.fromJson(value.data);
      //print(_homeModel.data.banners[0].image);
      emit(SuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateUserState());
    });
  }

//bool isDark = false;
// void changeAppMode({bool fromShared}) {
//   if (fromShared != null) {
//     isDark = fromShared;
//     emit(AppChangeModeState());
//   } else {
//     isDark = !isDark;
//     CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
//       emit(AppChangeModeState());
//     });
//   }
// }

}
