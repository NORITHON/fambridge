import 'package:fambridge/controller/family_consist_controller.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:get/get.dart';

import '../../../model/group.dart';
import '../../../service/crud/group_state_provider.dart';

class CheckMyselfView extends StatelessWidget {
  const CheckMyselfView({super.key});

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.numbersofFamilyRoute,
                );
              },
              child: CircleProfileBack(
                profile: ImageAssets.navigateBefore,
                size: 50,
              ),
            ),
            const SizedBox(
              width: 100,
            ),
            Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                  color: ColorManager.lightGrey, shape: BoxShape.circle),
            ),
            const SizedBox(
              width: 6,
            ),
            Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                  color: ColorManager.black, shape: BoxShape.circle),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            final familyConsistController = Get.put(FamilyConsistController());
            GroupStateProvider()
                      .newGroupInfo[GroupFirestoreFieldName.myRoleFieldName] = familyConsistController.getMySelfRole();
            Get.toNamed(Routes.LastquestionRoute);
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
        Wrap(
          children: buildCheckMySelfForm(),
        ),
      ],
    );
  }

  List<Widget> buildCheckMySelfForm() {
    final familyConsistController = Get.put(FamilyConsistController());

    List<Widget> result = [];
    List<int> familystate = familyConsistController.getTraget();
    Map<int, String> familySet = familyConsistController.familySetInvert;

    for (var i = 0; i < familystate.length; i++) {
      result.add(MenberButton(content: familySet[familystate[i]]!));
    }

    return result;
  }
}

PreferredSize onboardingAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      backgroundColor: ColorManager.white,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: TextButton(
          onPressed: () => Get.back(),
          child: Text("취소", style: TextStyle(color: ColorManager.lightGrey)),
        ),
      ),
      elevation: 3.0,
    ),
  );
}

PreferredSize onboardingLogoutAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(90),
    child: AppBar(
      backgroundColor: ColorManager.white,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 25, 20, 0),
          child: TextButton(
            onPressed: () => Get.toNamed(Routes.loginRoute),
            child:
                Text("로그아웃", style: TextStyle(color: ColorManager.lightGrey)),
          ),
        ),
      ],
      elevation: 3.0,
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

class CircleProfileBack extends StatelessWidget {
  double size;
  String profile;
  CircleProfileBack({
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
          backgroundColor: ColorManager.ButtonlightGrey,
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

class MenberButton extends StatelessWidget {
  MenberButton({
    required this.content,
    Key? key,
  }) : super(key: key);

  final familyConsistController = Get.put(FamilyConsistController());
  String content;

  @override
  Widget build(BuildContext context) {
    Map<String, int> familySet = familyConsistController.familySet;
    int index = familySet[content]!;
    double sizeOfWidth;
    if (index == 1) {
      sizeOfWidth = 90;
    } else if (index == 2) {
      sizeOfWidth = 80;
    } else {
      sizeOfWidth = 60;
    }

    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: GestureDetector(
          onTap: () {
            familyConsistController.targetMyself.value = index;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            width: sizeOfWidth,
            decoration: BoxDecoration(
              color: familyConsistController.targetMyself.value == index
                  ? ColorManager.point
                  : ColorManager.white,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: familyConsistController.targetMyself.value == index
                      ? ColorManager.white
                      : ColorManager.darkGrey),
            ),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: getMediumStyle(
                color: familyConsistController.targetMyself.value == index
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
