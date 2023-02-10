import 'package:fambridge/model/auth_user.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import '../presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'constants/app_state_fieldname/auth_state.dart';

@immutable
class MyApp extends StatefulWidget {
  MyApp._internal();
  static final MyApp instance =
      MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance; // factory for the class instance

  static final Map<String, Map<String, dynamic>> appState = {
    authStateFieldName : {
      hasGroupFieldName: false,
    },
  };
  static AuthUser? unsyncronizedAuthUser;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      title: 'norithon',
      initialRoute: Routes.splashRoute,
      // theme: getApplicationTheme(),
      getPages: getPages,
    );
  }
}
