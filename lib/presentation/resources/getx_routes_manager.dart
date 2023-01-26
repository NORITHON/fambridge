import 'package:fambridge/presentation/forgot_password/forgot_password.dart';
import 'package:fambridge/presentation/login/login.dart';
import 'package:fambridge/presentation/main/main_view.dart';
import 'package:fambridge/presentation/onboarding/onboarding.dart';
import 'package:fambridge/presentation/register/register.dart';
import 'package:fambridge/presentation/splash/splash.dart';
import 'package:fambridge/presentation/store_details/store_details.dart';
import 'package:get/route_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String storeDetailsRoute = "/storeDetails";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String verifyEmailRoute = "/verify-email";
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
    name: Routes.mainRoute,
    page: () => MainView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.storeDetailsRoute,
    page: () => StoreDetailsView(),
    transition: Transition.downToUp,
  ),
];
