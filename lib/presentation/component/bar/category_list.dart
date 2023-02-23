import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class AnswerListTabbar extends StatefulWidget {
  AnswerListTabbar({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  late TabController tabController;

  static const List<Widget> _tabs = [
    Tab(text: "전체"),
    Tab(text: "책갈피"),
  ];

  @override
  State<AnswerListTabbar> createState() => _AnswerListTabbarState();
}

class _AnswerListTabbarState extends State<AnswerListTabbar>
    with TickerProviderStateMixin {
  var currentTap = 0;

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
          tabs: AnswerListTabbar._tabs,

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
        ),

        //point underline containers
        Row(
          children: [
            Container(
              color: currentTap == 0 ? ColorManager.point : null,
              height: 2,
              width: MediaQuery.of(context).size.width / 2,
            ),
            Container(
              color: currentTap == 1 ? ColorManager.point : null,
              height: 2,
              width: MediaQuery.of(context).size.width / 2,
            )
          ],
        ),
      ],
    );
  }
}
