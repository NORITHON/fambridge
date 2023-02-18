import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onboardingappbar extends StatelessWidget {
  const Onboardingappbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (onboardingAppBar());
  }

  PreferredSizeWidget onboardingAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        backgroundColor: ColorManager.white,
        leading: TextButton(
          onPressed: () => Get.back(),
          child: Text("취소", style: TextStyle(color: ColorManager.lightGrey)),
        ),
        elevation: 0.0,
      ),
    );
  }
}
