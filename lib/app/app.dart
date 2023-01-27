import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import '../presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

@immutable
class MyApp extends StatefulWidget {
  MyApp._internal(); // private named constructor
  int appState = 0;
  static final MyApp instance =
      MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance; // factory for the class instance

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
      initialRoute: Routes.codeshareRoute,
      // theme: getApplicationTheme(),
      getPages: getPages,
    );
  }
}
