import 'package:bloc/bloc.dart';
import 'package:food_app_2/helper/api_helper.dart';
import 'package:food_app_2/helper/dialog_helper.dart';
import 'package:food_app_2/helper/firebase_helper.dart';
import 'package:food_app_2/model/appUser.dart';
import 'package:food_app_2/model/userModel_forDb.dart';

import '../helper/nav_observer.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(super.initialState);

  getUserData(context) async {
    AppUser? appUser = AppUser();
    try {
      appUser = await DatabaseHelper.service?.getUserDetails();
    } catch (e) {
      DialogueHelper.showErrorDialog(
          context!, (e as ApiFailure).message, false);
    }
  }

  createUserDB(
    context, {
    String url = "",
    var body,
  }) async {
    state.loginProcess = LoginProcess.NONE;
    try {
      if (state.loginProcess == LoginProcess.NONE) {
        emit(state.copyWith(loginProcess: LoginProcess.LOADING));
        var res = await APIHelper().createUserDetails(body: body);
        emit(state.copyWith(
            userModelDB: UserModelDB.fromJson(res),
            loginProcess: LoginProcess.DONE));
      }
    } catch (e) {
      emit(state.copyWith(loginProcess: LoginProcess.ERROR));
      await DialogueHelper.showErrorDialog(
          context!, (e as ApiFailure).message, false);
    }
  }
}

enum LoginProcess { NONE, LOADING, ERROR, DONE }

class UserDataState {
  AppUser? appUser = AppUser();
  UserModelDB? userModelDB = UserModelDB();
  LoginProcess? loginProcess;

  UserDataState(
      {this.appUser, this.loginProcess = LoginProcess.NONE, this.userModelDB});

  UserDataState copyWith(
      {AppUser? appUserData,
      LoginProcess? loginProcess,
      UserModelDB? userModelDB}) {
    return UserDataState(
        appUser: appUserData ?? this.appUser,
        loginProcess: loginProcess ?? this.loginProcess,
        userModelDB: userModelDB ?? this.userModelDB);
  }
}
