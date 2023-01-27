import 'package:fambridge/presentation/familyCode/input_family_code.dart';
import 'package:fambridge/presentation/forgot_id/forgot_id.dart';
import 'package:fambridge/presentation/forgot_password/forgot_password.dart';
import 'package:fambridge/presentation/home/home.dart';
import 'package:fambridge/presentation/login/login.dart';
import 'package:fambridge/presentation/main/main_view.dart';
import 'package:fambridge/presentation/mypage/mypage.dart';
import 'package:fambridge/presentation/onboarding/onboarding.dart';
import 'package:fambridge/presentation/register/register.dart';
import 'package:fambridge/presentation/splash/splash.dart';
import 'package:fambridge/presentation/start/startPage.dart';
import 'package:fambridge/presentation/store_details/store_details.dart';
import 'package:get/route_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotIdRoute = "/forgotIdRoute";
  static const String storeDetailsRoute = "/storeDetails";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String startRoute = "/start";
  static const String mainRoute = "/main";
  static const String homeRoute = "/home";
  static const String myPageRoute = "/myPage";
  static const String verifyEmailRoute = "/verify-email";
  static const String inputFamilyCodeRoute = "/add-familyCode";
}

List<GetPage<dynamic>> getPages = [
  GetPage(
    name: Routes.splashRoute,
    page: () => SplashView(),
    transition: Transition.fade,
  ),
  GetPage(
    name: Routes.loginRoute,
    page: () => LoginView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.onBoardingRoute,
    page: () => OnBoardingView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.registerRoute,
    page: () => RegisterView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.forgotPasswordRoute,
    page: () => ForgotPasswordView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.forgotIdRoute,
    page: () => ForgotIdView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.mainRoute,
    page: () => MainView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.homeRoute,
    page: () => HomeView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.myPageRoute,
    page: () => MyPageView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.startRoute,
    page: () => StartPage(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.storeDetailsRoute,
    page: () => StoreDetailsView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.inputFamilyCodeRoute,
    page: () => InputFamilyCode(),
    transition: Transition.downToUp,
  ),
];
