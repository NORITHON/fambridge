import 'package:fambridge/presentation/pages/onboarding/last_question_view.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({
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
            selectedIndex == 0 ? ImageAssets.navHomeHover : ImageAssets.navHome,
            width: 24,
            height: 24,
          ),
          label: '홈',
        ),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              selectedIndex == 1
                  ? ImageAssets.navListHover
                  : ImageAssets.navList,
              width: 24,
              height: 24,
            ),
            label: "리스트"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              selectedIndex == 2
                  ? ImageAssets.navStoreHover
                  : ImageAssets.navStore,
              width: 24,
              height: 24,
            ),
            label: "스토어"),
      ],
      backgroundColor: ColorManager.white,
      elevation: 0,
      currentIndex: selectedIndex,
      // selectedIconTheme: ,
      // unselectedIconTheme: ,
      selectedLabelStyle: textStyle.copyWith(
        fontWeight: FontWeightManager.medium,
        fontSize: FontSize.s12,
        height: 2,
      ),
      unselectedLabelStyle: textStyle.copyWith(
        fontWeight: FontWeightManager.medium,
        fontSize: FontSize.s12,
      ),
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorManager.point,
      selectedIconTheme: IconThemeData(color: ColorManager.point),
    );
  }
}
