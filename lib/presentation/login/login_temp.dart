import 'dart:developer';

import 'package:fambridge/presentation/common/custom_textfield.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/strings_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../resources/styles_manager.dart';

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
      resizeToAvoidBottomInset: false,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppPadding.p100),
        SvgPicture.asset(
          ImageAssets.appLogo,
          width: AppSize.s150,
          height: AppSize.s150,
        ),
        const SizedBox(height: AppPadding.p30),
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
            SizedBox(height: 100),
            SvgPicture.asset(
              ImageAssets.fambridgeIcon,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 30),
            Text("로그인",
                textAlign: TextAlign.center,
                style: getMediumStyle(
                  color: ColorManager.darkGrey,
                  fontSize: 16,
                )),
            SizedBox(height: 15),
            CustomTextfield(hintText: "아이디", controller: idController),
            SizedBox(
              height: 8,
            ),
            CustomTextfield(hintText: "비밀번호", controller: passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.forgotIdRoute);
                  },
                  child: Text(
                    "아이디",
                    style: getMediumStyle(
                      color: ColorManager.point,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  "/",
                  style: getMediumStyle(
                    color: ColorManager.point,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.forgotIdRoute);
                  },
                  child: Text(
                    "비밀번호 찾기",
                    style: getMediumStyle(
                      color: ColorManager.point,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.point,
                  padding: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Get.toNamed(Routes.homeRoute);
                  return;
                },
                child: Text(
                  "로그인",
                  style: getMediumStyle(
                    color: ColorManager.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              log("Clicked");
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
    );
  }
}
