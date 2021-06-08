part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitialState extends AppState {}

//class AppChangeModeState extends AppState {}

class ChangeBottomNavState extends AppState {}

class LoadingHomeDataState extends AppState {}

class SuccessHomeDataState extends AppState {}

class ErrorHomeDataState extends AppState {}

class SuccessCategoriesDataState extends AppState {}

class ErrorCategoriesDataState extends AppState {}

class ChangeFavoritesState extends AppState {}

class SuccessChangeFavoritesState extends AppState {
  final ChangeFavoritesModel model;

  SuccessChangeFavoritesState(this.model);
}

class ErrorChangeFavoritesState extends AppState {}

class LoadingGetFavoritesState extends AppState {}

class SuccessGetFavoritesState extends AppState {}

class ErrorGetFavoritesState extends AppState {}

class LoadingGetUserDataState extends AppState {}

class SuccessGetUserDataState extends AppState {
  final LoginModel loginModel;

  SuccessGetUserDataState(this.loginModel);
}

class ErrorGetUserDataState extends AppState {}

class LoadingUpdateUserState extends AppState {}

class SuccessUpdateUserState extends AppState {
  final LoginModel loginModel;

  SuccessUpdateUserState(this.loginModel);
}

class ErrorUpdateUserState extends AppState {}
