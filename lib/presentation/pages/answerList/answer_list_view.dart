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
            CustomTabbar(),
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

class CustomTabbar extends StatefulWidget {
  CustomTabbar({
    Key? key,
  }) : super(key: key);

  static const List<Widget> _tabs = [
    Tab(text: "전체"),
    Tab(text: "책갈피"),
  ];

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var currentTap = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          onTap: (index) {
            setState(() {
              currentTap = index;
            });
          },
          controller: _tabController,
          tabs: CustomTabbar._tabs,
          indicatorColor: ColorManager.point,
          indicatorWeight: 2,
          labelStyle: getMediumStyle(
            color: ColorManager.darkGrey,
            fontSize: AppSize.s16,
          ),
          unselectedLabelStyle: getMediumStyle(
            color: ColorManager.lightGrey,
            fontSize: AppSize.s16,
          ),
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
        ),
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
