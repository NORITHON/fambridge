import 'package:fambridge/presentation/pages/onboarding/check_myself_view.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:get/get.dart';

RxInt target = 0.obs;

class NumbersofFamilyView extends StatefulWidget {
  const NumbersofFamilyView({super.key});

  @override
  _numbersofFamilyState createState() => _numbersofFamilyState();
}

class _numbersofFamilyState extends State<NumbersofFamilyView> {
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
              Row(
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
                            color: ColorManager.lightGrey,
                            shape: BoxShape.circle),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 115,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.checkMyselfRoute,
                          arguments: {"familyMemberCount": target});
                    },
                    child: CircleProfile(
                      profile: ImageAssets.navigateNext,
                      size: 50,
                    ),
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

class ChoiceForm extends StatelessWidget {
  const ChoiceForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            SizedBox(
                width: 100,
                child: MemberCountButton(content: "할아버지", index: 2)),
            SizedBox(
                width: 80, child: MemberCountButton(content: "할머니", index: 3)),
          ],
        ),
        Row(
          children: const [
            MemberCountButton(content: "아빠", index: 4),
            MemberCountButton(content: "엄마", index: 5),
          ],
        ),
        Row(
          children: const [
            MemberCountButton(content: "첫째", index: 6),
            MemberCountButton(content: "둘째", index: 7),
            MemberCountButton(content: "셋째", index: 8),
            MemberCountButton(content: "넷째", index: 9),
          ],
        ),
        Row(
          children: const [
            SizedBox(
                width: 80, child: MemberCountButton(content: "다섯째", index: 10)),
            MemberCountButton(content: "기타", index: 11),
          ],
        ),
      ],
    );
  }
}

class MemberCountButton extends StatefulWidget {
  final String content;
  final int index;
  const MemberCountButton({
    required this.content,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<MemberCountButton> createState() => _MemberCountButtonState();
}

class _MemberCountButtonState extends State<MemberCountButton> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: GestureDetector(
          onTap: () {
            target.value = widget.index;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            width: 60,
            decoration: BoxDecoration(
              color: widget.index == target.value
                  ? ColorManager.point
                  : ColorManager.white,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: widget.index == target.value
                      ? ColorManager.white
                      : ColorManager.darkGrey),
            ),
            child: Text(
              widget.content,
              textAlign: TextAlign.center,
              style: getMediumStyle(
                color: widget.index == target.value
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
  final double size;
  final String profile;
  const CircleProfile({
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
