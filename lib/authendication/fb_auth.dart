import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:food_app_2/helper/api_helper.dart';
import 'package:food_app_2/helper/dialog_helper.dart';
import 'package:food_app_2/helper/firebase_helper.dart';
import 'package:food_app_2/helper/nav_helper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:food_app_2/model/userModel_forDb.dart';

import '../cubit/userdata_cubit.dart';

class FBAuth {
  String status = "";
  String msg = "";
  Future<void> signInWithFacebook(context) async {
    try {
      // FacebookLoginResult result = await FacebookLogin().logIn();
      LoginResult result = await FacebookAuth.instance
          .login(permissions: const ['email', 'public_profile']);
      status = result.status == LoginStatus.success
          ? "Success"
          : result.status == LoginStatus.cancelled
              ? "Cancel"
              : "Error";
      msg = status == "Success"
          ? "Login Success"
          : status == "Cancel"
              ? "Login Cancelled"
              : "Error occurred while Login";
      if (result.status == LoginStatus.success) {
        OAuthCredential faceBookCredential =
            FacebookAuthProvider.credential(result.accessToken?.token ?? "");
        var authResult = await FirebaseAuth.instance
            .signInWithCredential(faceBookCredential);
        print(authResult);
        await DatabaseHelper().updateUser(
            name: authResult.user?.displayName ?? "",
            email: authResult.user?.email ?? "",
            phone: authResult.user?.phoneNumber ?? "",
            uid: authResult.user?.uid ?? "",
            image: authResult.user?.photoURL ?? "");
        var appUser = await DatabaseHelper.service?.getUserDetails();
        UserModelDB user = UserModelDB();
        user.email = authResult.user?.email ?? "";
        user.name =
            Name(firstname: authResult.user?.displayName ?? "", lastname: "");
        user.phone = authResult.user?.email ?? "";
        user.password = "";
        user.username = authResult.user?.displayName ?? "";
        user.id = authResult.user?.uid ?? "";
        user.iV = 0;
        user.address = Address(
            geolocation: Geolocation(long: "", lat: ""),
            city: "",
            street: "",
            doorNumber: 0,
            zipcode: "");
        var res = await BlocProvider.of<UserDataCubit>(context)
            .createUserDB(context, body: user.toJson());
        print(res);
        print(appUser?.name);
        openScreen(dashBoard, requiresAsInitial: true);
        DialogueHelper().customToast(context, status: status, message: msg);
      } else if (result.status == LoginStatus.cancelled) {
        DialogueHelper().customToast(context, status: status, message: msg);
      } else if (result.status == LoginStatus.failed) {
        DialogueHelper().customToast(context, status: status, message: msg);
      }
    } catch (error) {
      if (error is FirebaseAuthException) {
        DialogueHelper.showErrorDialog(context, (error).message ?? "", false);
      } else {
        DialogueHelper.showErrorDialog(
            context, (error as ApiFailure).message, false);
      }
    }
  }
}
