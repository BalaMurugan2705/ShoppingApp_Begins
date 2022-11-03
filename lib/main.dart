import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food_app_2/cubit/product_cubit.dart';
import 'package:food_app_2/cubit/userdata_cubit.dart';
import 'package:food_app_2/helper/app_color.dart';
import 'helper/firebase_helper.dart';
import 'helper/app_localizations.dart';
import 'helper/nav_helper.dart';
import 'helper/nav_observer.dart';
import 'helper/utlis.dart';

void main() async {
  Utils.id = Platform.isAndroid ? Utils.androidId : Utils.iosId;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DatabaseHelper.service = DatabaseHelper();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  Locale _locale = Locale('en', '');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
            create: (context) => ProductCubit(ProductState())),
        BlocProvider<UserDataCubit>(
            create: (context) => UserDataCubit(UserDataState())),
      ],
      child: MaterialApp(
        title: 'Shopping App',
        locale: _locale,
        navigatorObservers: [NavObserver.instance],
        navigatorKey: NavObserver.navKey,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'), // English, no country code
          Locale('ar', 'AE'), // arab, no country code
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: AppColor.red1,
        ),
        initialRoute: route,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
