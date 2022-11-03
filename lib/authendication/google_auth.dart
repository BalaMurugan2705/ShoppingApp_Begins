import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_2/helper/app_localizations.dart';
import 'package:food_app_2/helper/nav_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../cubit/userdata_cubit.dart';
import '../helper/dialog_helper.dart';
import '../helper/firebase_helper.dart';
import '../helper/utlis.dart';
import '../model/userModel_forDb.dart';

class GoogleAuth {
  var authInstance = FirebaseAuth.instance;
  Future<void> googleSignIn(context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: Utils.id,
      scopes: ['profile', 'email'],
    );
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );
      UserCredential userCredential =
          await authInstance.signInWithCredential(credential);
      var userDetails = userCredential.user;
      DatabaseHelper().updateUser(
          name: userDetails?.displayName ?? "",
          lastname: "",
          email: userDetails?.email ?? "",
          password: "",
          city: "",
          street: "",
          doorNo: "",
          zipcode: "",
          phone: userDetails?.phoneNumber ?? "",
          uid: userDetails?.uid ?? "",
          image: userDetails?.photoURL ?? "");
      print(userDetails);
      var appUser = await DatabaseHelper.service?.getUserDetails();
      print(appUser?.name);
      UserModelDB user = UserModelDB();
      user.email = userCredential.user?.email ?? "";
      user.name =
          Name(firstname: userCredential.user?.displayName ?? "", lastname: "");
      user.phone = userCredential.user?.phoneNumber ?? "";
      user.password = "";
      user.username = userCredential.user?.displayName ?? "";
      user.id = userCredential.user?.uid ?? "";
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
      if (userCredential.user?.uid != "") {
        openScreen(dashBoard, requiresAsInitial: true);
        DialogueHelper().customToast(context,
            status: "Success",
            message: AppLocalizations.of(context)?.translate("successMsg"));
      } else {
        DialogueHelper().customToast(context,
            status: "Cancel",
            message: AppLocalizations.of(context)?.translate("cancelMsg"));
      }
    } catch (error) {
      print(error);
      DialogueHelper.showErrorDialog(context, (error).toString(), false);
    }
  }
}
