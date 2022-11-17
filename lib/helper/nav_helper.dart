import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_2/Screen/custom_dashboard.dart';
import 'package:food_app_2/Screen/forgot_screen.dart';
import 'package:food_app_2/Screen/login.dart';
import 'package:food_app_2/Screen/login_with_mob.dart';
import 'package:food_app_2/Screen/login_with_phone_otp.dart';
import 'package:food_app_2/Screen/otp.dart';
import 'package:food_app_2/Screen/product_details_screen.dart';
import 'package:food_app_2/Screen/setting_screen.dart';
import 'package:food_app_2/Screen/sign_up.dart';
import 'package:food_app_2/Screen/dashBoard.dart';
import 'package:food_app_2/Screen/splashscreen.dart';
import 'package:food_app_2/Screen/wlecome_screen.dart';

import '../Screen/bag.dart';
import '../Screen/home_page.dart';
import '../Screen/sign_up.dart';
import '../cubit/product_cubit.dart';
import 'nav_observer.dart';

const String landingRoute = "/landingRoute";
const String route = "/";
const String welcome = "/welcome";
const String homePage = "/main";
const String signUp = "/signUp";
const String login = "/login";
const String forgot = "/forgot";
const String loginWithMob = "/loginWithMob";
const String otpScreen = "/otp";
const String dashBoard = "/dashBoard";
const String settings = "/settings";
const String bag = "/bag";
const String productDetail = "/productDetail";

Route<Object?>? generateRoute(RouteSettings settings) {
  return getRoute(settings.name);
}

Route<Object?>? getRoute(String? name, {LinkedHashMap? args}) {
  switch (name) {
    case route:
      return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: RouteSettings(name: name));
    case welcome:
      return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
          settings: RouteSettings(name: name));
    case signUp:
      return MaterialPageRoute(
          builder: (context) => SignUp(), settings: RouteSettings(name: name));

    case homePage:
      return MaterialPageRoute(
          builder: (context) => HomePage(),
          settings: RouteSettings(name: name));
    case dashBoard:
      return MaterialPageRoute(
          builder: (context) => CustomDashboard(),
          settings: RouteSettings(name: name));
    case login:
      return MaterialPageRoute(
          builder: (context) => LoginScreen(),
          settings: RouteSettings(name: name));
    case forgot:
      return MaterialPageRoute(
          builder: (context) => ForgotScreen(),
          settings: RouteSettings(name: name));
    case loginWithMob:
      return MaterialPageRoute(
          builder: (context) => LoginWithPhoneOtp(),
          settings: RouteSettings(name: name));
    case otpScreen:
      return MaterialPageRoute(
          builder: (context) => OtpScreen(args),
          settings: RouteSettings(name: name));
    case settings:
      return MaterialPageRoute(
          builder: (context) => SettingScreen(),
          settings: RouteSettings(name: name));
    case productDetail:
      return MaterialPageRoute(
          builder: (context) => ProductDetails(args!),
          settings: RouteSettings(name: name));
    case bag:
      return MaterialPageRoute(
          builder: (context) => Bag(),
          settings: RouteSettings(name: name));
  }
  return null;
}

openScreen(String routeName,
    {bool forceNew = false,
    bool requiresAsInitial = false,
    LinkedHashMap? args}) {
  var route = getRoute(routeName, args: args);
  var context = NavObserver.navKey.currentContext;

  if (route != null && context != null) {

    if (requiresAsInitial) {
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else if (forceNew || !NavObserver.instance.containsRoute(route)) {
      Navigator.push(context, route);
    } else {
      Navigator.popUntil(context, (route) {
        if (route.settings.name == routeName) {
          if (args != null) {
            (route.settings.arguments as Map)["result"] = args;
          }
          return true;
        }
        return false;
      });
    }
  }
}

back(LinkedHashMap? args) {
  if (NavObserver.navKey.currentContext != null) {
    Navigator.pop(NavObserver.navKey.currentContext!, args);
  }
}
