import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_2/Screen/home_page.dart';
import 'package:food_app_2/Screen/profile.dart';
import 'package:food_app_2/Screen/shop.dart';
import 'package:food_app_2/helper/Style.dart';
import 'package:food_app_2/helper/app_color.dart';

import '../custom_directory/custom_navigator_bar.dart';
import '../widget/custom_scaffold.dart';
import 'bag.dart';
import 'favourite.dart';

class CustomDashboard extends StatelessWidget {
  CustomDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scafold(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              HomePage(),
              Shop(),
              Bag(),
              Favourite(),
              Profile(),
            ],
          ),
          CustomBottomNavigationBar()
        ],
      ),
    );
  }
}
