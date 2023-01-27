import 'package:fambridge/presentation/familyCode/input_family_code.dart';
import 'package:fambridge/presentation/forgot_id/forgot_id.dart';
import 'package:fambridge/presentation/forgot_password/forgot_password.dart';
import 'package:fambridge/presentation/home/check_comment.dart';
import 'package:fambridge/presentation/home/home.dart';
import 'package:fambridge/presentation/login/login.dart';
import 'package:fambridge/presentation/onboarding/Lastquestion.dart';
import 'package:fambridge/presentation/onboarding/codesharepage.dart';
import 'package:fambridge/presentation/onboarding/first_delayonboarding.dart';
import 'package:fambridge/presentation/onboarding/numbersofFamily.dart';
import 'package:fambridge/presentation/onboarding/onboarding.dart';
import 'package:fambridge/presentation/onboarding/second_delayonboarding.dart';
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
  static const String homeRoute = "/home";
  static const String myPageRoute = "/myPage";
  static const String checkCommentRoute = "/check-comment";
  static const String verifyEmailRoute = "/verify-email";
  static const String inputFamilyCodeRoute = "/add-familyCode";
  static const String numbersofFamilyRoute = "/number-family";
  static const String LastquestionRoute = "/last-question";
  static const String codeshareRoute = "/code-share";
  static const String first_delayRoute = "/first-onboarding";
  static const String second_delayRoute = "/second-onboarding";
}

List<GetPage<dynamic>> getPages = [
  GetPage(
    name: Routes.splashRoute,
    page: () => const SplashView(),
    transition: Transition.fade,
  ),
  GetPage(
    name: Routes.loginRoute,
    page: () => const LoginView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.onBoardingRoute,
    page: () => const OnBoardingView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.registerRoute,
    page: () => const RegisterView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.forgotPasswordRoute,
    page: () => const ForgotPasswordView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.forgotIdRoute,
    page: () => const ForgotIdView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.startRoute,
    page: () => const StartPage(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.storeDetailsRoute,
    page: () => const StoreDetailsView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.inputFamilyCodeRoute,
    page: () => const InputFamilyCode(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.homeRoute,
    page: () => const HomeView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.numbersofFamilyRoute,
    page: () => const numbersofFamilyView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.LastquestionRoute,
    page: () => const LastquestionView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.codeshareRoute,
    page: () => const codeshareview(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.checkCommentRoute,
    page: () => const CheckCommentView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.first_delayRoute,
    page: () => const first_delayView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.second_delayRoute,
    page: () => const second_delayView(),
    transition: Transition.downToUp,
  ),
];
