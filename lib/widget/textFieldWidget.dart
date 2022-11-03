import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/Style.dart';
import '../helper/app_color.dart';

class TextFieldButton extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? inputType;
  Function(String)? onChange;
  String? Function(String?)? validate;
  String labelText;
  String? hintText;
  bool centerLabel;
  String? initialValue;
  TextAlign textAlign;
  int? maxLine;
  int? minLine;
  double? fontsize;
  double? borderRadius;
  Color? color;
  Color? enableColor;
  FontWeight? fontweight;
  Color? fillcolor;
  bool? fill;
  double? letterSpace;
  bool? obscure;
  Color? textFontColor;
  String? textFontFamily;
  String? labelFontFamily;
  double? textFontSize;
  FontWeight? textFontWeight;
  bool? enable;
  Widget? prefix;
  Widget? suffix;
  List<TextInputFormatter>? inputFormat;
  FloatingLabelBehavior? floating;
  FocusNode? focusNode;
  TextFieldButton(
      {Key? key,
      this.suffix,
      this.inputFormat,
      this.enableColor,
      this.centerLabel = false,
      this.letterSpace,
      this.enable,
      this.textFontColor,
      this.textFontFamily,
      this.textFontSize,
      this.initialValue,
      this.textFontWeight,
      this.borderRadius,
      this.fontweight,
      this.fontsize,
      this.labelText = "",
      this.controller,
      this.onChange,
      this.inputType,
      this.validate,
      this.maxLine,
      this.hintText = "",
      required this.textAlign,
      this.color,
      this.fill,
      this.fillcolor,
      this.obscure,
      this.minLine = 1,
      this.prefix,
      this.labelFontFamily,
      this.floating = FloatingLabelBehavior.auto,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormat,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChange,
      keyboardType: inputType,
      validator: validate,
      style: FdStyle.sofia(
          fontWeight: FontWeight.w600, fontSize: 20, color: AppColor.appBlack1),
      cursorColor: AppColor.appBlack1,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: FdStyle.sofia(
              fontWeight: fontweight,
              fontSize: fontsize ?? 16,
              color: color ?? AppColor.appBlack1),
          floatingLabelBehavior: floating),
    );
  }
}
