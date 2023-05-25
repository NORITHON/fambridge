import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/font_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({
    Key? key,
    required this.selectedIndex,
    required this.bottomTapped,
  }) : super(key: key);
  final selectedIndex;
  final bottomTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.darkGrey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 25),
      child: BottomNavigationBar(
        onTap: (index) {
          bottomTapped(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              selectedIndex == 0
                  ? ImageAssets.navHomeHover
                  : ImageAssets.navHome,
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
        selectedLabelStyle: getRegularStyle(color: Colors.black).copyWith(
          fontWeight: FontWeightManager.medium,
          fontSize: FontSize.s12,
          height: 2,
        ),
        unselectedLabelStyle: getRegularStyle(color: Colors.black).copyWith(
          fontWeight: FontWeightManager.medium,
          fontSize: FontSize.s12,
        ),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorManager.point,
        selectedIconTheme: IconThemeData(color: ColorManager.point),
      ),
    );
  }
}
