import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/Style.dart';
import '../helper/app_color.dart';
import '../helper/app_localizations.dart';
import '../helper/app_vaditations.dart';
import '../helper/dialog_helper.dart';
import '../helper/firebase_helper.dart';
import '../helper/nav_helper.dart';
import '../widget/container_button.dart';
import '../widget/textFieldWidget.dart';

class LoginWithMob extends StatelessWidget {
  LoginWithMob({Key? key}) : super(key: key);

  TextEditingController phone = TextEditingController();
  ValueNotifier<bool> phone1 = ValueNotifier<bool>(false);
  TextEditingController otp = TextEditingController();
  ValueNotifier<bool> otp1 = ValueNotifier<bool>(false);
  bool phoneLogin = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            loginHeader(context),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: loginWithPhoneField(context),
              ),
            ),
            Center(
              child: continueButtonField(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginWithPhone(BuildContext context) async {
    try {
      await DatabaseHelper.service?.loginWithPhone("\+91" "${phone.text}");
    } catch (e) {
      return DialogueHelper.showErrorDialog(
          context, (e as FirebaseAuthException).message.toString(), false);
    }
  }

  Widget loginHeader(context) {
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
          AppLocalizations.of(context)?.translate("loginWithMob") ?? "",
          style: FdStyle.sofiaTitle(color: AppColor.titleBlack),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ],
    );
  }

  Widget loginWithPhoneField(context) {
    return Column(
      children: [
        phoneField(context),
        // otpField(context),
      ],
    );
  }

  Widget phoneField(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFieldButton(
                controller: phone,
                onChange: (val) {
                  if (val.isNotEmpty) {
                    phone1.value = true;
                  } else {
                    phone1.value = false;
                  }
                },
                inputType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                labelText:
                    AppLocalizations.of(context)?.translate("phone") ?? "",
                fontweight: FontWeight.w400,
                floating: FloatingLabelBehavior.auto,
                color: AppColor.textGrey,
              ),
            ),
            ValueListenableBuilder(
                valueListenable: phone1,
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

  // Widget otpField(context) {
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

  Widget continueButtonField(context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ContainerButton(
        onTap: () {
          if ((phone.text.isNotEmpty)) {
            if (!AppValidation.isPhoneNumberValid(phone.text)) {
              loginWithPhone(context);
            } else {
              DialogueHelper.showErrorDialog(
                  context, "Enter Valid Details to Login", false);
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
}
