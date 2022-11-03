import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app_2/helper/app_color.dart';
import '../main.dart';
import 'custom_cliper.dart';
import 'custom_nav_item.dart';

PageController pageController = PageController(initialPage: 0);
int currentIndex = 0;

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  initState() {
    currentIndex = 0;
    super.initState();
  }

  setPage() {
    setState(() {
      pageController.jumpToPage(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        // Theme.of(context).primaryColor.withAlpha(150),
                        // Theme.of(context).primaryColor,
                        Colors.teal,
                        Colors.teal.shade900
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Center(
                      child: CustomNavItem(
                          setPage: setPage,
                          icon: "assets/images/home_inActive.svg",
                          id: 0),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Center(
                      child: CustomNavItem(
                          setPage: setPage,
                          icon: "assets/images/shop_inActive.svg",
                          id: 1),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Center(
                      child: CustomNavItem(
                          setPage: setPage,
                          icon: "assets/images/bag_inActive.svg",
                          id: 2),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Center(
                      child: CustomNavItem(
                          setPage: setPage,
                          icon: "assets/images/favourite_inActive.svg",
                          id: 3),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Center(
                      child: CustomNavItem(
                          setPage: setPage,
                          icon: "assets/images/profile_inActive.svg",
                          id: 4),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Center(
                      child: Text(
                        'Home',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: currentIndex == 0
                                ? AppColor.appWhite1
                                : Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Center(
                      child: Text(
                        'Shop',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: currentIndex == 1
                              ? AppColor.appWhite1
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Center(
                      child: Text(
                        'Bag',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: currentIndex == 2
                                ? AppColor.appWhite1
                                : Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Center(
                      child: Text(
                        'Favourite',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: currentIndex == 3
                                ? AppColor.appWhite1
                                : Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: currentIndex == 4
                                ? AppColor.appWhite1
                                : Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
