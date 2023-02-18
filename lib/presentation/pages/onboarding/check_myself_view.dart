import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:get/get.dart';

RxInt target = 0.obs;

class CheckMyselfView extends StatefulWidget {
  const CheckMyselfView({super.key});

  @override
  _checkMyselfState createState() => _checkMyselfState();
}

class _checkMyselfState extends State<CheckMyselfView> {
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
                "나는 '누구'인가요?",
                textAlign: TextAlign.left,
                style: getMediumStyle(
                  color: ColorManager.point,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 85),
              const ChoiceForm(),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.LastquestionRoute, arguments: {
                        "familyMemberCount": Get.arguments['familyMemberCount'],
                        "UserFamilyOrder": target,
                      });
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
        Wrap(
          children: buildCheckMySelfForm(),
        ),
      ],
    );
  }

  List<Widget> buildCheckMySelfForm() {
    List<Widget> result = [];
    var n = int.parse(Get.arguments['familyMemberCount'].toString());

    List<String> familyMember = [
      "엄마",
      "아빠",
      "첫째",
      "둘째",
      "셋째",
      "넷째",
      "다섯째",
      "여섯째",
      "일곱째",
      "여덟째",
      "아홉째",
      "열째",
    ];

    for (var i = 0; i < n; i++) {
      result.add(MenberCountButton(content: familyMember[i], index: i + 1));
    }
    return result;
  }
}

class MenberCountButton extends StatefulWidget {
  String content;
  int index;
  MenberCountButton({
    required this.content,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<MenberCountButton> createState() => _MenberCountButtonState();
}

class _MenberCountButtonState extends State<MenberCountButton> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: GestureDetector(
          onTap: () {
            target.value = widget.index;
          },
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
      ),
    );
  }
}

PreferredSize onboardingAppBar() {
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
