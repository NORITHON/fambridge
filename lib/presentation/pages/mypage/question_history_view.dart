import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class QuestionHistoryView extends StatefulWidget {
  const QuestionHistoryView({super.key});

  @override
  State<QuestionHistoryView> createState() => _QuestionHistoryViewState();
}

class _QuestionHistoryViewState extends State<QuestionHistoryView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this, //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _MypageAppBar(),
      body: Column(
        children: [
          _TapBar(tabController: _tabController),
          Expanded(
            child: _TapbarView(tabController: _tabController),
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget _MypageAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      title: Text(
        "질문 목록",
        style: getMediumStyle(
          fontSize: 18,
          color: ColorManager.darkGrey,
        ),
      ),
      centerTitle: true,
      backgroundColor: ColorManager.white,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: SvgPicture.asset(
          ImageAssets.back,
          height: 20,
          width: 20,
          fit: BoxFit.scaleDown,
        ),
      ),
      elevation: 0.0,
    ),
  );
}

class _TapbarView extends StatelessWidget {
  const _TapbarView({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        //전체 목록
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: ListView.separated(
            itemCount: 7,
            itemBuilder: (context, index) {
              return QuestListComponent(
                number: index,
                question: "이것은 질문입니다.",
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 8,
            ),
          ),
        ),
        //저장 목록
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: ListView.separated(
            itemCount: 7,
            itemBuilder: (context, index) {
              return QuestListComponent(
                number: index,
                question: "이것은 질문입니다.",
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 8,
            ),
          ),
        ),
      ],
    );
  }
}

class _TapBar extends StatelessWidget {
  const _TapBar({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Container(
          height: 60,
          alignment: Alignment.center,
          child: const Text(
            '전체',
          ),
        ),
        Container(
          height: 60,
          alignment: Alignment.center,
          child: const Text(
            '저장',
          ),
        ),
      ],
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3, color: ColorManager.point),
        ),
        gradient: LinearGradient(
          //배경 그라데이션 적용
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.orange.withOpacity(0.1),
          ],
        ),
      ),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      controller: _tabController,
    );
  }
}

class QuestListComponent extends StatelessWidget {
  final int number;
  final String question;

  const QuestListComponent({
    Key? key,
    required this.number,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 30, 28, 30),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.darkGrey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 0), // changes position of shadow
          )
        ],
      ),
      child: Row(
        children: [
          Text(
            "${number.toString()}. ",
            style: getBoldStyle(
              color: ColorManager.point,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              question,
              style: getMediumStyle(
                color: ColorManager.darkGrey,
                fontSize: 16,
              ),
            ),
          ),
          SvgPicture.asset(ImageAssets.saveFalse),
        ],
      ),
    );
  }
}
