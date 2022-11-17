import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_2/helper/app_color.dart';
import 'package:food_app_2/helper/nav_helper.dart';

import '../cubit/product_cubit.dart';
import '../helper/Style.dart';
import '../helper/preferenceHelper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  checkLogin(BuildContext context) async {
    if (await PreferenceHelper.getInitialLogin()) {
      openScreen(dashBoard, requiresAsInitial: true);
     await BlocProvider.of<ProductCubit>(context).getAllProducts(context);
    } else {
      openScreen(signUp, requiresAsInitial: true);
     await BlocProvider.of<ProductCubit>(context).getAllProducts(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      checkLogin(context);
    });
    return Scaffold(
      backgroundColor: AppColor.appWhite1,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/Begins.gif"),
            // InkWell(
            //   onTap: () {
            //     openScreen(login, requiresAsInitial: true);
            //     print("object");
            //   },
            //   child: Text(
            //     "Click To Proceed",
            //     style: FdStyle.sofia(color: AppColor.appBlack1),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
