import 'dart:async';

import 'package:fambridge/presentation/login/login_view.dart';
import 'package:fambridge/presentation/onboarding/onboarding.dart';
import 'package:fambridge/service/auth/auth_service.dart';

import '../resources/assets_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.firebase().getAuthStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppLogo();
        } else if (snapshot.hasData) {
          return FutureBuilder(
            future: Future.wait([Future.delayed(const Duration(seconds: 2))]),
            builder: (context, snapshot) {
              switch(snapshot.connectionState){
                case ConnectionState.done:
                  return const LoginView();
                default:
                  return const AppLogo();
              }
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went Wrong!"),
          );
        } else {
          return const OnBoardingView();
        }
    },);
  }
}
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo),
        ),
      );
  }
}
