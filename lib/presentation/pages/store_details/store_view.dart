import 'package:fambridge/presentation/component/bar/category_store.dart';
import 'package:fambridge/presentation/component/card/store_coupon.dart';
import 'package:fambridge/presentation/component/card/store_mebership.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

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
        body: Container(
          color: ColorManager.questionbackgroundColor,
          child: Column(
            children: [
              const StoreMembership(),
              StoreTabbar(tabController: tabController),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(25, 9, 25, 9),
                  child: TabBarView(
                    controller: tabController,
                    children: views,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> views = [
    //전체
    const BuildCouponList(),
    //식사
    const BuildCouponList(),
    //선물
    const BuildCouponList(),
    //여가
    const BuildCouponList(),
  ];
}

class BuildCouponList extends StatelessWidget {
  const BuildCouponList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        return const StoreCoupon();
      },
      separatorBuilder: (
        BuildContext context,
        int index,
      ) =>
          const SizedBox(
        height: 0,
      ),
    );
  }
}
