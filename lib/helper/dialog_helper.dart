import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_2/helper/Style.dart';
import 'package:food_app_2/helper/app_color.dart';
import 'package:food_app_2/helper/app_localizations.dart';
import 'package:food_app_2/helper/nav_helper.dart';
import 'package:food_app_2/widget/container_button.dart';

class DialogueHelper {
  static showErrorDialog(
      BuildContext context, String msg, bool barrierDismissible,
      {Function()? onTap}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (builder) {
        return AlertDialog(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Icon(
            Icons.error,
            color: AppColor.red1,
            size: 40,
          ),
          content: Text(
            msg,
            style: FdStyle.metropolisRegular(),
            textAlign: TextAlign.center,
          ),
          actions: [
            ContainerButton(
              buttonSize: 40,
              buttonTitle: AppLocalizations.of(context)?.translate("ok") ?? "",
              textColor: AppColor.appWhite1,
              backGroundColor: AppColor.red1,
              onTap: () {
                onTap ?? back(LinkedHashMap());
              },
            )
          ],
        );
      },
    );
  }

  customToast(BuildContext context, {String? status, String? message}) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: status == "Success"
                  ? AppColor.checkGreen
                  : status == "Cancel"
                      ? AppColor.amber
                      : status == "Error"
                          ? AppColor.red1
                          : AppColor.titleBlack,

// title: new Text("Alert!!"),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            status == "Success"
                                ? "assets/images/toast_success.svg"
                                : status == "Cancel"
                                    ? "assets/images/toast_warning.svg"
                                    : status == "Error"
                                        ? "assets/images/toast_error.svg"
                                        : "assets/images/toast_icon.svg",
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              message.toString(),
                              style: FdStyle.sofia(
                                color: AppColor.appWhite1,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppColor.appWhite1,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget progressIndicator() {
    return CircularProgressIndicator(
      backgroundColor: AppColor.amber,
      color: AppColor.teal,
      strokeWidth: 6,
    );
  }
}
