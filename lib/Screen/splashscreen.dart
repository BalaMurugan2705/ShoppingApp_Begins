import 'package:flutter/material.dart';
import 'package:food_app_2/helper/app_color.dart';
import 'package:food_app_2/helper/nav_helper.dart';

import '../helper/Style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appWhite1,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/Begins.gif"),
            InkWell(
              onTap: () {
                openScreen(login, requiresAsInitial: true);
                print("object");
              },
              child: Text(
                "Click To Proceed",
                style: FdStyle.sofia(color: AppColor.appBlack1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
