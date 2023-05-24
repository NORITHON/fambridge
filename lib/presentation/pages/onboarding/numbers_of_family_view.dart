import 'package:fambridge/controller/family_consist_controller.dart';
import 'package:fambridge/presentation/pages/onboarding/check_myself_view.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:get/get.dart';

class NumbersofFamilyView extends StatelessWidget {
  const NumbersofFamilyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: onboardingAppBar(),
      body: Container(
        color: ColorManager.backgroundColor,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 110),
              Text(
                "누구와 함께 사용할건가요?",
                textAlign: TextAlign.left,
                style: getMediumStyle(
                  color: ColorManager.point,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 75),
              const ChoiceForm(),
              const SizedBox(height: 100),
              const NavIndicate(),
            ],
          ),
        ),
      ),
    );
  }
}

class NavIndicate extends StatelessWidget {
  const NavIndicate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                  color: ColorManager.black, shape: BoxShape.circle),
            ),
            const SizedBox(
              width: 6,
            ),
            Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                  color: ColorManager.lightGrey, shape: BoxShape.circle),
            ),
          ],
        ),
        const SizedBox(
          width: 115,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.checkMyselfRoute,
            );
          },
          child: CircleProfile(
            profile: ImageAssets.navigateNext,
            size: 50,
          ),
        ),
      ],
    );
  }
}

class ChoiceForm extends StatelessWidget {
  const ChoiceForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 100, child: MenberCountButton(content: "할아버지")),
            SizedBox(width: 80, child: MenberCountButton(content: "할머니")),
          ],
        ),
        Row(
          children: [
            MenberCountButton(content: "아빠"),
            MenberCountButton(content: "엄마"),
          ],
        ),
        Row(
          children: [
            MenberCountButton(content: "첫째"),
            MenberCountButton(content: "둘째"),
            MenberCountButton(content: "셋째"),
            MenberCountButton(content: "넷째"),
          ],
        ),
      ],
    );
  }
}

class MenberCountButton extends StatelessWidget {
  MenberCountButton({
    required this.content,
    Key? key,
  }) : super(key: key);

  final familyConsistController = Get.put(FamilyConsistController());
  String content;

  @override
  Widget build(BuildContext context) {
    Map<String, int> familySet = familyConsistController.familySet;
    int index = familySet[content]!;

    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: GestureDetector(
          onTap: () {
            if (familyConsistController.target.contains(index)) {
              familyConsistController.target.remove(index);
            } else {
              familyConsistController.target.add(index);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            width: 60,
            decoration: BoxDecoration(
              color: familyConsistController.target.contains(index)
                  ? ColorManager.point
                  : ColorManager.white,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: familyConsistController.target.contains(index)
                      ? ColorManager.white
                      : ColorManager.darkGrey),
            ),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: getMediumStyle(
                color: familyConsistController.target.contains(index)
                    ? ColorManager.white
                    : ColorManager.darkGrey,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleProfile extends StatelessWidget {
  double size;
  String profile;
  CircleProfile({
    Key? key,
    required this.profile,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: CircleAvatar(
          backgroundColor: ColorManager.point,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: Image.asset(
              profile,
              height: size,
              width: size,
            ),
          ),
        ));
  }
}
