import 'package:flutter/material.dart';

import '../helper/app_color.dart';

class ContainerButton extends StatelessWidget {
  String? buttonTitle;
  Color? backGroundColor;
  Color? textColor;
  Color? borderColor;
  double? buttonSize;
  String? fontFamily;
  FontWeight? fontWeight;
  void Function()? onTap;
  double? radius;
  EdgeInsetsGeometry? padding;

  ContainerButton(
      {Key? key,
      this.buttonTitle = "",
      this.backGroundColor,
      this.textColor,
      this.fontFamily,
      this.fontWeight,
      this.onTap,
      this.borderColor,
      this.radius,
      this.buttonSize = 60,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: padding,
          height: buttonSize,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: backGroundColor ?? AppColor.red1,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              buttonTitle ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: fontWeight ?? FontWeight.w500,
                fontSize: 18,
                fontFamily: fontFamily ?? "Sofia pro",
                color: textColor ?? AppColor.appWhite1,
              ),
            ),
          )),
    );
  }
}
