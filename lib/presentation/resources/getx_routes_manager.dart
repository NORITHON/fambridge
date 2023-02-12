import 'package:fambridge/presentation/pages/familyCode/input_family_code.dart';
import 'package:fambridge/presentation/pages/home/answer_question_view.dart';
import 'package:fambridge/presentation/pages/home/homepage.dart';
import 'package:fambridge/presentation/pages/login/login_view.dart';
import 'package:fambridge/presentation/pages/onboarding/Lastquestion.dart';
import 'package:fambridge/presentation/pages/onboarding/check_myself.dart';
import 'package:fambridge/presentation/pages/onboarding/codesharepage.dart';
import 'package:fambridge/presentation/pages/onboarding/first_delayonboarding.dart';
import 'package:fambridge/presentation/pages/onboarding/numbersofFamily.dart';
import 'package:fambridge/presentation/pages/onboarding/second_delayonboarding.dart';
import 'package:fambridge/presentation/pages/register/register.dart';
import 'package:fambridge/presentation/pages/splash/splash.dart';
import 'package:fambridge/presentation/pages/start/startPage.dart';
import 'package:fambridge/presentation/pages/store_details/store_details.dart';
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
  static const String answerQuestionRoute = "/answer-question";
  static const String verifyEmailRoute = "/verify-email";
  static const String inputFamilyCodeRoute = "/add-familyCode";
  static const String numbersofFamilyRoute = "/number-family";
  static const String LastquestionRoute = "/last-question";
  static const String codeshareRoute = "/code-share";
  static const String firstDelayRoute = "/first-onboarding";
  static const String secondDelayRoute = "/second-onboarding";
  static const String checkMyselfRoute = "/check-myself";
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
    name: Routes.registerRoute,
    page: () => const RegisterView(),
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
    page: () => const NumbersofFamilyView(),
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
    name: Routes.answerQuestionRoute,
    page: () => const AnswerQuestionView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.firstDelayRoute,
    page: () => const firstDelayView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.secondDelayRoute,
    page: () => const second_delayView(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: Routes.checkMyselfRoute,
    page: () => const CheckMyselfView(),
    transition: Transition.downToUp,
  ),
];
