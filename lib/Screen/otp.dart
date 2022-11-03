import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app_2/helper/dialog_helper.dart';
import 'package:food_app_2/helper/firebase_helper.dart';

import '../helper/Style.dart';
import '../helper/app_color.dart';
import '../helper/app_localizations.dart';
import '../helper/nav_helper.dart';
import '../widget/container_button.dart';
import '../widget/textFieldWidget.dart';

class OtpScreen extends StatefulWidget {
  String? otpValue;
  String? verificationId;
  OtpScreen(Object? args, {Key? key}) : super(key: key) {
    if (args is LinkedHashMap) {
      if (args.containsKey("otpValue")) {
        otpValue = args["otpValue"];
      }
      if (args.containsKey("verificationId")) {
        verificationId = args["verificationId"];
      }
    }
  }

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp = TextEditingController();
  ValueNotifier<bool> otp1 = ValueNotifier<bool>(false);

  @override
  void initState() {
    otp.text = widget.otpValue ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            otpHeader(context),
            Center(
              child: otpField(context),
            ),
            Center(
              child: continueButtonField(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget otpHeader(context) {
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
          AppLocalizations.of(context)?.translate("otpVerification") ?? "",
          style: FdStyle.sofiaTitle(color: AppColor.titleBlack),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ],
    );
  }

  Widget otpField(context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: TextFieldButton(
                  controller: otp,
                  onChange: (val) {
                    if (val.isNotEmpty) {
                      otp1.value = true;
                    } else {
                      otp1.value = false;
                    }
                  },
                  inputType: TextInputType.emailAddress,
                  textAlign: TextAlign.start,
                  labelText:
                      AppLocalizations.of(context)?.translate("otp") ?? "",
                  fontweight: FontWeight.w400,
                  floating: FloatingLabelBehavior.auto,
                  color: AppColor.textGrey,
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: otp1,
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
      ),
    );
  }

  Widget continueButtonField(context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ContainerButton(
        onTap: () {
          sighInWithOtp(otp.text);
        },
        backGroundColor: AppColor.red1,
        buttonSize: 50,
        buttonTitle: AppLocalizations.of(context)?.translate("continue") ?? "",
        radius: 40,
      ),
    );
  }

  Future<void> sighInWithOtp(String otpValue) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId ?? "", smsCode: otpValue);
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .catchError((e) {
      DialogueHelper.showErrorDialog(context, e.message.toString(), false);
    }).then((value) {
      print(value);
    });
    openScreen(dashBoard);
  }
}
