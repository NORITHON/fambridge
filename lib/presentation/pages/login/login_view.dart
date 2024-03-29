import 'dart:developer';
import 'package:fambridge/app/app.dart';
import 'package:fambridge/app/constants/app_state_fieldname/auth_state.dart';
import 'package:fambridge/app/constants/app_state_fieldname/group_state.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/strings_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:fambridge/presentation/utilities/loading_dialog.dart';
import 'package:fambridge/service/auth/auth_service.dart';
import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/group.dart';
import '../splash/splash_view.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p45),
          child: SizedBox(
            width: double.infinity,
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController idController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    idController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    idController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: AppPadding.p150),
          const AppLogo(size: AppSize.s100),
          const SizedBox(height: AppPadding.p100),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                loadingDialog(context);
                try {
                  MyApp.unsyncronizedAuthUser =
                      await AuthService.firebase().logIn();
                } catch (_) {
                  Get.close(1);
                  return;
                }
                if (!MyApp.appState[authStateFieldName]![hasGroupFieldName]) {
                  Get.back();
                  Get.toNamed(Routes.inputFamilyCodeRoute);
                } else {
                  // auth 그룹이름이 이미 있는 경우
                  log(MyApp.unsyncronizedAuthUser!.groupId ?? "no group Id");
                  final Stream<Group> groupStream = GroupService.firebase()
                      .getGroup(groupId: MyApp.unsyncronizedAuthUser!.groupId!);
                  MyApp.appState[groupStateFieldName]![groupFieldName] =
                      groupStream;

                  final Group group = await groupStream.first;

                  if (group.userIdsInGroup.length <
                      group.totalNumOfFamilyMember) {
                    // 가족이 다 들어오지 않았다면,
                    Get.offAllNamed(Routes.secondDelayRoute, arguments: group);
                  } else {
                    // 가족이 다 들어왔다면,
                    Get.offAllNamed(Routes.buildPages);
                  }
                }
              },
              child: const Text(
                AppStrings.login,
              ),
            ),
          ),
          SignInWithAppleButton(
            onPressed: () async {
              final credential = await SignInWithApple.getAppleIDCredential(
                scopes: [
                  AppleIDAuthorizationScopes.email,
                  AppleIDAuthorizationScopes.fullName,
                ],
              );

              print(credential);

              // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
              // after they have been validated with Apple (see `Integration` section for more information on how to do this)
            },
          ),
          const SizedBox(height: AppPadding.p40),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const Text(AppStrings.registeredYet),
          //     TextButton(
          //       onPressed: () => Get.toNamed(Routes.registerRoute),
          //       //onPressed: () => Get.toNamed(Routes.splashRoute),
          //       child: const Text(
          //         AppStrings.signup,
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}

// Future<void> signInWithApple() async {
//   try {
//     final appleCredential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//     );

//     final oauthCredential = OAuthProvider("apple.com").credential(
//       idToken: appleCredential.identityToken,
//       accessToken: appleCredential.authorizationCode,
//     );

//     final authResult =
//         await FirebaseAuth.instance.signInWithCredential(oauthCredential);
//     (authResult.user);
//     AuthService.firebase().logIn();
//     return Future<void>.value();
//   } catch (error) {
//     (null);
//     return Future<void>.value();
//   }
// }

