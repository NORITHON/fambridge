import 'package:fambridge/presentation/component/bar/category_list.dart';
import 'package:fambridge/presentation/component/bar/category_store.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

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
          title: const Text("스토어"),
          toolbarHeight: AppSize.s60,
          backgroundColor: ColorManager.backgroundColor,
          elevation: 7,
          shadowColor: ColorManager.shadowColor,
        ),
        body: Column(
          children: [
            Container(
              color: ColorManager.white,
              child: StoreTabbar(),
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
