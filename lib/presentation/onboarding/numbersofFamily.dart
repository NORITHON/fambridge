import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

RxInt target = 0.obs;

class numbersofFamilyView extends StatefulWidget {
  const numbersofFamilyView({super.key});

  @override
  _numbersofFamilyState createState() => _numbersofFamilyState();
}

class _numbersofFamilyState extends State<numbersofFamilyView> {
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
                "가족 구성원은 몇 명인가요?",
                textAlign: TextAlign.left,
                style: getMediumStyle(
                  color: ColorManager.darkGrey,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 75),
              ChoiceForm(),
              CircleProfile(
                profile: ImageAssets.navigateNext,
                size: 30,
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
            MenberCountButton(content: "2명", index: 2),
            MenberCountButton(content: "3명", index: 3),
          ],
        ),
        Row(
          children: [
            MenberCountButton(content: "4명", index: 4),
            MenberCountButton(content: "5명", index: 5),
            MenberCountButton(content: "6명", index: 6),
            MenberCountButton(content: "7명", index: 7),
          ],
        ),
        Row(
          children: [
            MenberCountButton(content: "8명", index: 8),
            MenberCountButton(content: "9명", index: 9),
            MenberCountButton(content: "10명", index: 10),
          ],
        ),
        Row(
          children: [
            MenberCountButton(content: "기타", index: 11),
          ],
        ),
      ],
    );
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
