import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_app_2/helper/dialog_helper.dart';
import 'package:food_app_2/helper/secure_storage_helper.dart';
import 'package:food_app_2/model/appUser.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'nav_helper.dart';

class DatabaseHelper {
  String? userId, token;
  User? loggedInUser;
  AppUser? appUser;
  static DatabaseHelper? service;

  DatabaseHelper({this.userId});

  static DatabaseHelper getInstance() {
    return service ??= DatabaseHelper();
  }

  var authInstance = FirebaseAuth.instance;
  var dbStore = FirebaseFirestore.instance;

  String? verificationId;

  Future<User?> loginWithEmail(String email, String password) async {
    return await authInstance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((authUser) {
      if (authUser.user != null) {
        loggedInUser = authUser.user;
        return loggedInUser;
      }
    });
  }

  loginWithPhone(String phoneNumber) async {
    return await authInstance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    // setState(() {
    //   this.otpCode.text = authCredential.smsCode!;
    // });
    openScreen(otpScreen,
        args: LinkedHashMap.from({"otpValue": authCredential.smsCode}));
    if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
            await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await authInstance.signInWithCredential(authCredential);
        }
      }
      // setState(() {
      //   isLoading = false;
      // });
      openScreen(dashBoard);
    }
  }

  _onVerificationFailed(
    FirebaseAuthException exception,
  ) {
    if (exception.code == 'invalid-phone-number') {
      var str = "The phone number entered is invalid!";
      print(str);
      //   Fluttertoast.showToast(
      //       msg: str,
      //       backgroundColor: AppColor.red1,
      //       textColor: AppColor.appWhite1,
      //       fontSize: 16);
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");
    openScreen(otpScreen,
        args: LinkedHashMap.from({"verificationId": verificationId}));
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  void showMessage(String errorMessage, context) {
    DialogueHelper.showErrorDialog(context, errorMessage, false);
  }

  Future<String> CreateUser(context,
      {String? username,
      String? lastname,
      String? email,
      String? password,
      String? city,
      String? street,
      String? doorNo,
      String? zipcode,
      String? phone,
      String? image}) async {
    var userId;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email ?? "",
      password: password ?? "",
    )
        .catchError(
      (onError) {
        print(onError);
      },
    ).then((value) async {
      if (value.user != null && value.user!.uid.isNotEmpty) {
        await updateUser(
            name: username ?? "",
            lastname: lastname ?? "",
            email: email ?? "",
            password: password ?? "",
            city: city ?? "",
            street: street ?? "",
            doorNo: doorNo ?? "",
            zipcode: zipcode ?? "",
            phone: phone ?? "",
            uid: value.user!.uid,
            image: image ?? "");
        print("User Created Successfully");
        userId = value.user!.uid;
      }
    });
    return userId;
  }

  Future updateUser(
      {String? name,
      String? lastname,
      String? email,
      String? password,
      String? city,
      String? street,
      String? doorNo,
      String? zipcode,
      String? phone,
      String? uid,
      String? image}) async {
    print("user Updated in Firestore");
    return await dbStore.collection("Users").doc(uid)
      ..set(
        {
          "uid": uid ?? "",
          "Name": name ?? "",
          "LastName": lastname ?? "",
          "Email": email ?? "",
          "Password": password ?? "",
          "City": city ?? "",
          "Street": street ?? "",
          "Door No": doorNo ?? "",
          "Zipcode": zipcode ?? "",
          "Phone": phone ?? "",
          "image": image ?? ""
        },
      );
  }

  //Code by Kali
  // Future<AppUser?> getUserDetails() async {
  //   loggedInUser = authInstance.currentUser;
  //   if (loggedInUser != null) {
  //     DocumentSnapshot snapshot =
  //         await dbStore.collection("Users").doc(loggedInUser!.uid).get();
  //     appUser = AppUser().fromMap(
  //       snapshot.data() as LinkedHashMap,
  //     );
  //   }
  //   return appUser;
  // }

  //Code change for shared preference
  Future<AppUser?> getUserDetails() async {
    loggedInUser = authInstance.currentUser;
    if (loggedInUser != null) {
      DocumentSnapshot snapshot =
          await dbStore.collection("Users").doc(loggedInUser!.uid).get();
      appUser = AppUser().fromMap(
        snapshot.data() as LinkedHashMap,
      );
      SecureStorage.saveUserData(appUser!);
    }
    return appUser;
  }

  getToken() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token) {
      print(token);
      this.token = token; // Print the Token in Console
    });
  }
}
