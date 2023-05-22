import 'package:fambridge/presentation/common/custom_textfield.dart';
import 'package:fambridge/presentation/home/view_model.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/strings_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:fambridge/presentation/utilities/loading_dialog.dart';
import 'package:fambridge/service/auth/auth_service.dart';
import 'package:fambridge/service/group/group_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/styles_manager.dart';
import '../splash/splash.dart';

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
          const SizedBox(height: AppPadding.p180),
          const AppLogo(size: AppSize.s85),
          const SizedBox(height: AppPadding.p100),
          Text(
            AppStrings.login,
            textAlign: TextAlign.center,
            style: getRegularStyle(color: ColorManager.darkGrey),
          ),
          const SizedBox(height: AppPadding.p14),
          CustomTextfield(hintText: AppStrings.loginId, controller: idController),
          const SizedBox(
            height: AppPadding.p8,
          ),
          CustomTextfield(
              hintText: AppStrings.loginPwd, controller: passwordController),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.forgotIdRoute);
                },
                child: const Text(
                  AppStrings.loginId,
                ),
              ),
              Text(
                "/",
                style: getRegularStyle(color: ColorManager.darkGrey),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.forgotIdRoute);
                },
                child: const Text(
                  "${AppStrings.loginPwd} ${AppStrings.loginFind}",
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                loadingDialog(context);
                await AuthService.firebase().logIn();
                final user = await AuthService.firebase().currentUser;
                if (user!.name == null) {
                  Get.back();
                  Get.toNamed(Routes.inputFamilyCodeRoute);
                } else{
                  AuthService.nonSyncronizedUser = user;
                  final question = await GroupService.firebase().getTodayGroupQuestion(groupId: user.groupId!);
                  Get.put(AnswerViewModel())
                      .init(
                          groupId: user.groupId!,
                          userId: user.id,
                          todayGroupQuestionId: question.groupQuestionId)
                      .then((_) => Get.offAllNamed(Routes.homeRoute));
                }
                
              },
              child: const Text(
                AppStrings.login,
              ),
            ),
          ),
          const SizedBox(height: AppPadding.p40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(AppStrings.registeredYet),
              TextButton(
                onPressed: () => Get.toNamed(Routes.registerRoute),
                child: const Text(
                  AppStrings.signup,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
