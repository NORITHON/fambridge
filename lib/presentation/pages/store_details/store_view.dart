import 'package:fambridge/presentation/component/bar/category_store.dart';
import 'package:fambridge/presentation/component/card/store_mebership.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  static const List<Widget> _views = [
    const Center(child: const Text('Content of Tab One')),
    const Center(child: const Text('Content of Tab Two')),
    const Center(child: const Text('Content of Tab Three')),
    const Center(child: const Text('Content of Tab Four')),
  ];

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
            StoreMembership(),
            Container(
              color: ColorManager.white,
              child: StoreTabbar(tabController: tabController),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: StoreView._views,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
