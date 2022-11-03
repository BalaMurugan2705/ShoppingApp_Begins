import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app_2/helper/Style.dart';
import 'package:food_app_2/helper/app_color.dart';
import 'package:food_app_2/helper/app_localizations.dart';
import 'package:food_app_2/helper/app_vaditations.dart';
import 'package:food_app_2/helper/firebase_helper.dart';
import 'package:food_app_2/widget/container_button.dart';
import 'package:food_app_2/widget/custom_scaffold.dart';
import 'package:food_app_2/widget/textFieldWidget.dart';

import '../authendication/fb_auth.dart';
import '../authendication/google_auth.dart';
import '../helper/api_helper.dart';
import '../helper/dialog_helper.dart';
import '../helper/nav_helper.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController name = TextEditingController();
  ValueNotifier<bool> name1 = ValueNotifier<bool>(false);
  TextEditingController email = TextEditingController();
  ValueNotifier<bool> email1 = ValueNotifier<bool>(false);
  TextEditingController password = TextEditingController();
  ValueNotifier<bool> password1 = ValueNotifier<bool>(false);
  // TextEditingController phone = TextEditingController();
  // ValueNotifier<bool> phone1 = ValueNotifier<bool>(false);
  // TextEditingController otp = TextEditingController();
  // ValueNotifier<bool> otp1 = ValueNotifier<bool>(false);
  // bool phoneLogin = false;
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Scafold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    loginHeader(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Column(
                        children: [
                          // phoneLogin
                          //     ? loginWithPhoneField()
                          //     :
                          loginWithEmailField(),
                          forgotPasswordField(),
                          // loginWithMobField(),
                        ],
                      ),
                    ),
                    continueButtonField(),
                    loginWithMobField(),
                    signUpField(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    socialAccountLoginField(),
                    socialAccountsField(),
                  ],
                ),
                Visibility(
                  visible: visible,
                  child: DialogueHelper().progressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          (AppLocalizations.of(context)?.translate("signUp") ?? "") + "?",
          style: FdStyle.sofia(
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            // setState(() {
            //   phoneLogin = !phoneLogin;
            // });
            openScreen(signUp);
          },
          child: Text(
            AppLocalizations.of(context)?.translate("yes") ?? "",
            style: TextStyle(color: AppColor.red1),
          ),
        ),
      ],
    );
  }

  Widget loginWithMobField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)?.translate("loginWithPhone") ?? "",
          style: FdStyle.sofia(
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            // setState(() {
            //   phoneLogin = !phoneLogin;
            // });
            openScreen(loginWithMob);
          },
          child: Text(
            AppLocalizations.of(context)?.translate("yes") ?? "",
            style: TextStyle(color: AppColor.red1),
          ),
        ),
      ],
    );
  }

  void loginWithEmail(BuildContext context) async {
    try {
      setState(() {
        visible = true;
      });
      var user = await DatabaseHelper.service
          ?.loginWithEmail(email.text, password.text);
      if (DatabaseHelper.service?.loggedInUser != null) {
        await DatabaseHelper.service?.getUserDetails();
        if (mounted) {
          DialogueHelper().customToast(context,
              status: AppLocalizations.of(context)?.translate("login") ?? "",
              message:
                  AppLocalizations.of(context)?.translate("loginSuccess") ??
                      "");
          setState(() {
            visible = true;
          });
          openScreen(dashBoard);
        }
      }
    } catch (e) {
      return DialogueHelper.showErrorDialog(
          context, (e as FirebaseAuthException).message.toString(), false);
    }
  }

  // Future<void> loginWithPhone(BuildContext context) async {
  //   try {
  //     await DatabaseHelper.service?.loginWithPhone("\+91" "${phone.text}");
  //   } catch (e) {
  //     return DialogueHelper.showErrorDialog(
  //         context, (e as FirebaseAuthException).message.toString(), false);
  //   }
  // }

  Widget loginWithEmailField() {
    return Column(
      children: [
        emailField(),
        passwordField(),
      ],
    );
  }

  // Widget loginWithPhoneField() {
  //   return Column(
  //     children: [
  //       phoneField(),
  //       otpField(),
  //     ],
  //   );
  // }

  Widget loginHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            back(null);
          },
          child: Image.asset(
            "assets/images/icon.png",
            height: 30,
            width: 30,
          ),
        ),
        Text(
          AppLocalizations.of(context)?.translate("login") ?? "",
          style: FdStyle.sofiaTitle(color: AppColor.titleBlack),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ],
    );
  }

  Widget emailField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFieldButton(
                controller: email,
                onChange: (val) {
                  if (val.isNotEmpty) {
                    email1.value = true;
                  } else {
                    email1.value = false;
                  }
                },
                inputType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                labelText:
                    AppLocalizations.of(context)?.translate("email") ?? "",
                fontweight: FontWeight.w400,
                floating: FloatingLabelBehavior.auto,
                color: AppColor.textGrey,
              ),
            ),
            ValueListenableBuilder(
                valueListenable: email1,
                builder: (context, bool val, child) {
                  return Visibility(
                    visible: val,
                    child: Icon(
                      Icons.check,
                      color: AppColor.checkGreen,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  // Widget phoneField() {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: TextFieldButton(
  //               controller: phone,
  //               onChange: (val) {
  //                 if (val.isNotEmpty) {
  //                   phone1.value = true;
  //                 } else {
  //                   phone1.value = false;
  //                 }
  //               },
  //               inputType: TextInputType.emailAddress,
  //               textAlign: TextAlign.start,
  //               labelText:
  //                   AppLocalizations.of(context)?.translate("phone") ?? "",
  //               fontweight: FontWeight.w400,
  //               floating: FloatingLabelBehavior.auto,
  //               color: AppColor.textGrey,
  //             ),
  //           ),
  //           ValueListenableBuilder(
  //               valueListenable: phone1,
  //               builder: (context, bool val, child) {
  //                 return Visibility(
  //                   visible: val,
  //                   child: Icon(
  //                     Icons.check,
  //                     color: AppColor.checkGreen,
  //                   ),
  //                 );
  //               })
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget passwordField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFieldButton(
                controller: password,
                onChange: (val) {
                  if (val.isNotEmpty) {
                    password1.value = true;
                  } else {
                    password1.value = false;
                  }
                },
                inputType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                labelText:
                    AppLocalizations.of(context)?.translate("password") ?? "",
                fontweight: FontWeight.w400,
                floating: FloatingLabelBehavior.auto,
                color: AppColor.textGrey,
              ),
            ),
            ValueListenableBuilder(
                valueListenable: password1,
                builder: (context, bool val, child) {
                  return Visibility(
                    visible: val,
                    child: Icon(
                      Icons.check,
                      color: AppColor.checkGreen,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  // Widget otpField() {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: TextFieldButton(
  //               controller: otp,
  //               onChange: (val) {
  //                 if (val.isNotEmpty) {
  //                   otp1.value = true;
  //                 } else {
  //                   otp1.value = false;
  //                 }
  //               },
  //               inputType: TextInputType.emailAddress,
  //               textAlign: TextAlign.start,
  //               labelText: AppLocalizations.of(context)?.translate("otp") ?? "",
  //               fontweight: FontWeight.w400,
  //               floating: FloatingLabelBehavior.auto,
  //               color: AppColor.textGrey,
  //             ),
  //           ),
  //           ValueListenableBuilder(
  //               valueListenable: otp1,
  //               builder: (context, bool val, child) {
  //                 return Visibility(
  //                   visible: val,
  //                   child: Icon(
  //                     Icons.check,
  //                     color: AppColor.checkGreen,
  //                   ),
  //                 );
  //               })
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget forgotPasswordField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)?.translate("forgotPassword") ?? "",
          style: FdStyle.sofia(
            fontSize: 14,
          ),
        ),
        IconButton(
            onPressed: () {
              openScreen(forgot);
            },
            icon: Icon(
              Icons.arrow_right_alt,
              color: AppColor.red1,
            ))
      ],
    );
  }

  // Widget loginWithMobField() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Text(
  //         phoneLogin
  //             ? AppLocalizations.of(context)?.translate("loginWithEmail") ?? ""
  //             : AppLocalizations.of(context)?.translate("loginWithPhone") ?? "",
  //         style: FdStyle.sofia(
  //           fontSize: 14,
  //         ),
  //       ),
  //       TextButton(
  //         onPressed: () {
  //           setState(() {
  //             phoneLogin = !phoneLogin;
  //           });
  //         },
  //         child: Text(
  //           AppLocalizations.of(context)?.translate("yes") ?? "",
  //           style: TextStyle(color: AppColor.red1),
  //         ),
  //       )
  //     ],
  //   );
  // }

  Widget continueButtonField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ContainerButton(
        onTap: () {
          if ((email.text.isNotEmpty && password.text.isNotEmpty)
              // ||
              // (phone.text.isNotEmpty)
              ) {
            if (!AppValidation.isEmailValid(email.text)) {
              loginWithEmail(context);
              // } else if (!AppValidation.isPhoneNumberValid(phone.text)) {
              //   loginWithPhone(context);
              // }
            } else {
              DialogueHelper.showErrorDialog(
                  context, "Enter the Valid Details to Login", false);
            }
          } else {
            DialogueHelper.showErrorDialog(
                context, "Enter the Details to Login", false);
          }
        },
        backGroundColor: AppColor.red1,
        buttonSize: 50,
        buttonTitle: AppLocalizations.of(context)?.translate("continue") ?? "",
        radius: 40,
      ),
    );
  }

  Widget socialAccountLoginField() {
    return Center(
      child: Text(
        AppLocalizations.of(context)?.translate("loginWithSocialAccount") ?? "",
        style: FdStyle.sofia(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget socialAccountsField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            setState(() {
              visible = true;
            });
            await GoogleAuth().googleSignIn(context);
            setState(() {
              visible = false;
            });
          },
          child: Image.asset(
            "assets/images/Google.png",
            height: 100,
            width: 100,
          ),
        ),
        InkWell(
          onTap: () async {
            setState(() {
              visible = true;
            });
            await FBAuth().signInWithFacebook(context);
            setState(() {
              visible = false;
            });
          },
          child: Image.asset(
            "assets/images/Facebook.png",
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }
}
