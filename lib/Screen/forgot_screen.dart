import 'package:flutter/material.dart';
import 'package:food_app_2/helper/Style.dart';
import 'package:food_app_2/helper/app_color.dart';
import 'package:food_app_2/widget/container_button.dart';
import 'package:food_app_2/widget/custom_scaffold.dart';
import 'package:food_app_2/widget/textFieldWidget.dart';

import '../helper/nav_helper.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({Key? key}) : super(key: key);
  TextEditingController name = TextEditingController();
  ValueNotifier<bool> name1 = ValueNotifier<bool>(false);
  TextEditingController email = TextEditingController();
  ValueNotifier<bool> email1 = ValueNotifier<bool>(false);
  TextEditingController password = TextEditingController();
  ValueNotifier<bool> password1 = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scafold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
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
                  "Forgot password",
                  style: FdStyle.sofiaTitle(color: AppColor.titleBlack),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Please, enter your email address. You will receive a link to create a new password via email.",
                    style: FdStyle.sofia(color: AppColor.titleBlack),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Card(
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
                                  inputType: TextInputType.number,
                                  textAlign: TextAlign.start,
                                  labelText: "Email",
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
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ContainerButton(
                    backGroundColor: AppColor.red1,
                    buttonSize: 50,
                    buttonTitle: "Send",
                    radius: 40,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
