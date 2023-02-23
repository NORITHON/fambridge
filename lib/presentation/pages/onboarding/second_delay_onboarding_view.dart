import 'package:fambridge/presentation/component/button/copybutton.dart';
import 'package:fambridge/presentation/component/button/sharebutton.dart';
import 'package:fambridge/presentation/pages/onboarding/check_myself_view.dart';
import 'package:fambridge/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class second_delayView extends StatefulWidget {
  const second_delayView({super.key});

  @override
  _second_delayState createState() => _second_delayState();
}

class _second_delayState extends State<second_delayView> {
  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 2), () {
    //   Get.offAllNamed(Routes.buildPages);
    // });
  }

  @override
  Widget build(BuildContext context) {
    var idController = "24983827";
    return Scaffold(
      appBar: onboardingLogoutAppBar(),
      body: Container(
        color: ColorManager.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Fambridge",
                style: getMediumStyle(
                    color: ColorManager.buttonDisable, fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "'우리'라는 이름 아래 모인 우리 ",
                style:
                    getMediumStyle(color: ColorManager.darkGrey, fontSize: 16),
              ),
              const SizedBox(height: 140),
              const FamilyList(),
              const SizedBox(
                height: 110,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "가족 코드",
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      color: ColorManager.darkGrey,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  Text(
                    idController,
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.darkGrey,
                      fontSize: FontSize.s20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Copybutton(),
                  Sharebutton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FamilyList extends StatelessWidget {
  const FamilyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        FamilyMember(type: "아빠", profile: ImageAssets.profile2),
        FamilyMember(type: "엄마", profile: ImageAssets.profile2),
        FamilyMember(type: "첫째", profile: ImageAssets.profile2),
        FamilyMember(type: "둘째", profile: ImageAssets.profile2),
        FamilyMember(type: "셋째", profile: ImageAssets.profile2),
      ],
    );
  }
}

class FamilyMember extends StatelessWidget {
  final String type;
  final String profile;
  const FamilyMember({
    required this.type,
    required this.profile,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleProfile(size: 44, profile: profile),
        const SizedBox(
          height: 5,
        ),
        Text(
          type,
          style: getMediumStyle(
            color: ColorManager.darkGrey,
            fontSize: 16,
          ),
        ),
      ],
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: CircleAvatar(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: SvgPicture.asset(
              profile,
              height: size,
              width: size,
              allowDrawingOutsideViewBox: true,
            ),
          ),
        ));
  }
}
