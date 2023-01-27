import 'dart:async';

import 'package:fambridge/presentation/resources/font_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
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
    Timer(Duration(seconds: 2), () {
      Get.toNamed(Routes.homeRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 220),
              const FamilyList(),
              const SizedBox(
                height: 50,
              ),
              Text(
                "가장 가깝지만 멀었던",
                textAlign: TextAlign.center,
                style: getMediumStyle(
                  color: ColorManager.point,
                  fontSize: FontSize.s16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "'우리'를 알아가는 시간을 보내세요",
                textAlign: TextAlign.center,
                style: getMediumStyle(
                  color: ColorManager.point,
                  fontSize: FontSize.s16,
                ),
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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FamilyMember(type: "아빠", profile: ImageAssets.onboardingLogo3),
          FamilyMember(type: "엄마", profile: ImageAssets.onboardingLogo3),
          FamilyMember(type: "첫째", profile: ImageAssets.onboardingLogo3),
          FamilyMember(type: "둘째", profile: ImageAssets.onboardingLogo3),
          FamilyMember(type: "셋째", profile: ImageAssets.onboardingLogo3),
        ],
      ),
    );
  }
}

class FamilyMember extends StatelessWidget {
  String type;
  String profile;
  FamilyMember({
    required this.type,
    required this.profile,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleProfile(size: 44, profile: profile),
        SizedBox(
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
