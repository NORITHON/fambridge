import 'package:fambridge/presentation/component/button/button_check.dart';
import 'package:fambridge/presentation/pages/onboarding/check_myself_view.dart';
import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LastquestionView extends StatefulWidget {
  const LastquestionView({super.key});

  @override
  _LastquestionState createState() => _LastquestionState();
}

class _LastquestionState extends State<LastquestionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: onboardingAppBar(),
      body: Container(
        color: ColorManager.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              Text(
                "축하합니다.",
                textAlign: TextAlign.center,
                style:
                    getRegularStyle(color: ColorManager.darkGrey, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "곧이어 가족 코드가 발행됩니다.",
                textAlign: TextAlign.center,
                style:
                    getRegularStyle(color: ColorManager.darkGrey, fontSize: 18),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "모든 '우리'가 모여야",
                textAlign: TextAlign.center,
                style:
                    getRegularStyle(color: ColorManager.darkGrey, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "서비스가 시작됩니다.",
                textAlign: TextAlign.center,
                style:
                    getRegularStyle(color: ColorManager.darkGrey, fontSize: 18),
              ),
              const SizedBox(
                height: 140,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 240,
                    child: ButtonCheck(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


