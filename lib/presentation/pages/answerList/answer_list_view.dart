import 'package:fambridge/presentation/component/bar/category_list.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          elevation: 0,
          title: const Text("질문 목록"),
          toolbarHeight: AppSize.s60,
          backgroundColor: ColorManager.backgroundColor,
          shadowColor: ColorManager.shadowColor,
        ),
        body: Column(
          children: [
            Container(
              child: AnswerListTabbar(),
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
