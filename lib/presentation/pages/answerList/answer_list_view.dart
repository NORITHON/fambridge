import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AnswerListView extends StatelessWidget {
  const AnswerListView({super.key});

  static const List<Widget> _views = [
    const Center(child: const Text('Content of Tab One')),
    const Center(child: const Text('Content of Tab Two')),
  ];

  static const List<Widget> _tabs = [
    Tab(
      text: "전체",
    ),
    Tab(
      text: "책갈피",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset(
              ImageAssets.back,
              height: 20,
              width: 20,
              fit: BoxFit.scaleDown,
            ),
          ),
          title: const Text("질문"),
          toolbarHeight: AppSize.s60,
          backgroundColor: ColorManager.backgroundColor,
          elevation: 7,
          shadowColor: ColorManager.shadowColor,
        ),
        body: Column(
          children: [
            TabBar(
              labelStyle: getMediumStyle(
                color: ColorManager.darkGrey,
                fontSize: AppSize.s16,
              ),
              unselectedLabelStyle: getMediumStyle(
                color: ColorManager.lightGrey,
                fontSize: AppSize.s16,
              ),
              indicatorColor: ColorManager.point,
              indicatorWeight: 2,
              tabs: _tabs,
            ),
            Expanded(
              child: TabBarView(
                children: _views,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
