import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_2/Screen/home_page.dart';
import 'package:food_app_2/Screen/profile.dart';
import 'package:food_app_2/Screen/shop.dart';
import 'package:food_app_2/helper/Style.dart';
import 'package:food_app_2/helper/app_color.dart';

import '../widget/custom_scaffold.dart';
import 'bag.dart';
import 'favourite.dart';

class DashBoard extends StatelessWidget {
  DashBoard({Key? key}) : super(key: key);

  PageController pageController = PageController(initialPage: 0);
  ValueNotifier<int> pageNavigationIconNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scafold(
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: pageNavigationIconNotifier,
        builder: (context, value, child) {
          return BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: SvgPicture.asset(
                  "assets/images/home_inActive.svg",
                  color: AppColor.appBlack1,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/images/home_active.svg",
                  color: AppColor.red1,
                ),
              ),
              BottomNavigationBarItem(
                label: "Shop",
                icon: SvgPicture.asset("assets/images/shop_inActive.svg",
                    color: AppColor.appBlack1),
                activeIcon: SvgPicture.asset(
                  "assets/images/shop_active.svg",
                  color: AppColor.red1,
                ),
              ),
              BottomNavigationBarItem(
                label: "Bag",
                icon: SvgPicture.asset("assets/images/bag_inActive.svg",
                    color: AppColor.appBlack1),
                activeIcon: SvgPicture.asset(
                  "assets/images/bag_active.svg",
                  color: AppColor.red1,
                ),
              ),
              BottomNavigationBarItem(
                label: "Favourites",
                icon: SvgPicture.asset("assets/images/favourite_inActive.svg",
                    color: AppColor.appBlack1),
                activeIcon: SvgPicture.asset(
                  "assets/images/favourite_active.svg",
                  color: AppColor.red1,
                ),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: SvgPicture.asset("assets/images/profile_inActive.svg",
                    color: AppColor.appBlack1),
                activeIcon: SvgPicture.asset(
                  "assets/images/profile_active.svg",
                  color: AppColor.red1,
                ),
              )
            ],
            backgroundColor: Color(0x00000000),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: AppColor.red1,
            // unselectedItemColor: AppColor.appBlack1,
            currentIndex: int.parse(value.toString()),
            onTap: (index) {
              getPage(index);
            },
          );
        },
      ),
      child: PageView(
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
    );
  }

  getPage(int index) {
    pageNavigationIconNotifier.value = index;
    pageController.jumpToPage(index);
  }
}
