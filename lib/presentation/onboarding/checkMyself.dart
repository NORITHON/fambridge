import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

RxInt target = 0.obs;

class checkMyselfView extends StatefulWidget {
  const checkMyselfView({super.key});

  @override
  _checkMyselfState createState() => _checkMyselfState();
}

class _checkMyselfState extends State<checkMyselfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _MypageAppBar(),
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
                  color: ColorManager.darkGrey,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 85),
              ChoiceForm(),
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
        Row(
          children: [
            MenberCountButton(content: "아빠", index: -1),
            MenberCountButton(content: "엄마", index: -2),
          ],
        ),
        Row(
          children: buildCheckMySelfForm(),
        ),
      ],
    );
  }

  List<Widget> buildCheckMySelfForm() {
    List<Widget> result = [];
    var n = int.parse(Get.arguments['familyMemberCount']);
    print("familyMemberCount : $n");

    MenberCountButton(content: "첫째", index: 1);
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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

PreferredSizeWidget _MypageAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      title: Text(
        "",
        style: getMediumStyle(
          fontSize: 18,
          color: ColorManager.darkGrey,
        ),
      ),
      centerTitle: true,
      backgroundColor: ColorManager.white,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: SvgPicture.asset(
          ImageAssets.back,
          height: 20,
          width: 20,
          fit: BoxFit.scaleDown,
        ),
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
