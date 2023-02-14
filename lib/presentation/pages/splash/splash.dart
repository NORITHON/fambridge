import 'dart:async';

import 'package:fambridge/presentation/pages/login/login_view.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:fambridge/service/auth/auth_service.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter/material.dart';

import '../home/homepage.dart';

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
            future: Future.wait([AuthService.firebase().currentUser.then((authUser) => AuthService.firebase().updateLastLoginTime(authUser: authUser),) ]),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if(!snapshot.hasData) return const LoginView();
                  if(snapshot.data!.first == null) return const LoginView();
                  AuthService.firebase().initAuthStateForApp(authUser: snapshot.data!.first!);
                  return const HomeView();
                default:
                  return Scaffold(
                    backgroundColor: ColorManager.buttonDisable,
                    body: const Center(child: AppLogo()),
                  );
              }
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something went Wrong!"),
          );
        } else {
          return const LoginView();
        }
      },
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = AppSize.s100});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ImageAssets.appLogo,
      width: size,
      height: size,
    );
  }
}
