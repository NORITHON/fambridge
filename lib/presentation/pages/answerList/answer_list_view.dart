import 'package:fambridge/presentation/component/bar/category_list.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AnswerListView extends StatelessWidget {
  const AnswerListView({super.key});

  static const List<Widget> _views = [
    const Center(child: const Text('Content of Tab One')),
    const Center(child: const Text('Content of Tab Two')),
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
          elevation: 0,
          title: const Text("질문"),
          toolbarHeight: AppSize.s60,
          backgroundColor: ColorManager.backgroundColor,
          shadowColor: ColorManager.shadowColor,
        ),
        body: Column(
          children: [
            AnswerListTabbar(),
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
