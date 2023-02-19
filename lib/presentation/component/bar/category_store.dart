import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class StoreTabbar extends StatefulWidget {
  StoreTabbar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  late TabController tabController;

  @override
  State<StoreTabbar> createState() => _StoreTabbarState();
}

class _StoreTabbarState extends State<StoreTabbar>
    with TickerProviderStateMixin {
  var currentTap = 0;

  static const List<Widget> tabs = [
    Tab(text: "전체"),
    Tab(text: "식사"),
    Tab(text: "선물"),
    Tab(text: "여가"),
  ];

  @override
  Widget build(BuildContext context) {
    //tabbar + underline container
    return Column(
      children: [
        TabBar(
          onTap: (index) {
            setState(() {
              currentTap = index;
            });
          },
          controller: widget.tabController,
          tabs: tabs,
          //indicator style start
          indicatorColor: ColorManager.point,
          indicatorWeight: 2,
          indicator: BoxDecoration(
            color: ColorManager.point,
            //배경 그라데이션 적용
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorManager.white,
                ColorManager.lightpoint,
              ],
            ),
          ),
          //indicator style end

          //label style start
          labelStyle: getMediumStyle(
            color: ColorManager.darkGrey,
            fontSize: AppSize.s16,
          ),
          labelColor: ColorManager.darkGrey,
          unselectedLabelStyle: getMediumStyle(
            color: ColorManager.point,
            fontSize: AppSize.s16,
          ),
          unselectedLabelColor: ColorManager.lightGrey,
          //label style end
        ),
        //underline container
        Row(
          children: [
            Container(
              color: currentTap == 0 ? ColorManager.point : null,
              height: 2,
              width: MediaQuery.of(context).size.width / 4,
            ),
            Container(
              color: currentTap == 1 ? ColorManager.point : null,
              height: 2,
              width: MediaQuery.of(context).size.width / 4,
            ),
            Container(
              color: currentTap == 2 ? ColorManager.point : null,
              height: 2,
              width: MediaQuery.of(context).size.width / 4,
            ),
            Container(
              color: currentTap == 3 ? ColorManager.point : null,
              height: 2,
              width: MediaQuery.of(context).size.width / 4,
            )
          ],
        ),
      ],
    );
  }
}
