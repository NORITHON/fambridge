import 'package:fambridge/presentation/pages/onboarding/Lastquestion.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomnavButton extends StatelessWidget {
  const BottomnavButton({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);
  final selectedIndex;
  final onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/images/Home.svg",
            width: 24,
            height: 24,
          ),
          label: '홈',
        ),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/Dashboard.svg",
              width: 24,
              height: 24,
            ),
            label: "리스트"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/Store.svg",
              width: 24,
              height: 24,
            ),
            label: "스토어"),
      ],
      currentIndex: selectedIndex,
      // selectedIconTheme: ,
      // unselectedIconTheme: ,
      selectedLabelStyle: textStyle.copyWith(
        fontWeight: FontWeightManager.medium,
        fontSize: FontSize.s12,
        height: 3.5,
      ),
      unselectedLabelStyle: textStyle.copyWith(
        fontWeight: FontWeightManager.medium,
        fontSize: FontSize.s12,
        height: 3.5,
      ),
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManager.point,
      selectedIconTheme: IconThemeData(color: ColorManager.point),
    );
  }
}
