import 'package:fambridge/presentation/component/bar/category_list.dart';
import 'package:fambridge/presentation/component/card/list.dart';
import 'package:fambridge/presentation/component/widgets/answer_view_list.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class AnswerListView extends StatefulWidget {
  const AnswerListView({super.key});

  @override
  State<AnswerListView> createState() => _AnswerListViewState();
}

class _AnswerListViewState extends State<AnswerListView>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
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
            AnswerListTabbar(tabController: tabController),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: _views,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        titlePadding: const EdgeInsets.all(0),
        title: Stack(
          children: [
            Positioned(
              right: 24,
              top: 20,
              child: IconButton(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(0),
                icon: SvgPicture.asset(
                  ImageAssets.dialogBack,
                ),
                onPressed: () {
                  Get.back();
                }, //do something,
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 48, left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "#1",
                      style: getMediumStyle(
                        color: ColorManager.lightGrey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: 240,
                      child: WrappedKoreanText(
                        textAlign: TextAlign.center,
                        "우리가족은 어떤 가족인가요?",
                        style: getMediumStyle(
                            color: ColorManager.black, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: EdgeInsets.fromLTRB(32, 0, 32, 20),
                      child: AnswerViewListBuilder(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  late final List<Widget> _views = [
    //전체 목록
    ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: openDialog,
          child: AnswerCardComponent(
            number: index + 1,
            question: "우리 가족은 어떤 가족인가요?",
            numberOfAnswerdFamily: 5,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 8,
      ),
    ),

    //책갈피 목록
    ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: openDialog,
          child: AnswerCardComponent(
            number: index + 1,
            question: "우리 가족은 어떤 가족인가요?",
            numberOfAnswerdFamily: 5,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 8,
      ),
    ),
  ];
}
