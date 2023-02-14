// ignore_for_file: unnecessary_const

import 'dart:developer';

import 'package:fambridge/app/app.dart';
import 'package:fambridge/model/group.dart';
import 'package:fambridge/presentation/component/widgets/answer_button.dart';
import 'package:fambridge/presentation/component/widgets/buttom_sheet_background.dart';
import 'package:fambridge/presentation/component/widgets/growing_tree.dart';
import 'package:fambridge/presentation/component/widgets/question_sheet.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/service/auth/auth_service.dart';
import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../component/group_stream_builder.dart';
import '../../resources/font_manager.dart';
import '../../resources/values_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (MyApp.unsyncronizedAuthUser == null) return;

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await AuthService.firebase()
          .updateLastLoginTime(authUser: MyApp.unsyncronizedAuthUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    log(MyApp.unsyncronizedAuthUser!.groupId!);
    return Scaffold(
      body: MyApp.unsyncronizedAuthUser == null
          ? const Center(
              child: Text("cannot find login info"),
            )
          : GroupStreamBuilder(
              groupId: MyApp.unsyncronizedAuthUser!.groupId!,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text("cannot find family group info"),
                      );
                    }
                    if (GroupService.firebase().shouldReplaceTodayQuestion(
                        group: snapshot.data!,
                        user: MyApp.unsyncronizedAuthUser!)) {
                      return FutureBuilder(
                        future: GroupService.firebase()
                            .replaceTodayQuestionToTheNextQuestion(
                                group: snapshot.data!),
                        builder: (BuildContext context,
                            AsyncSnapshot<void> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.done:
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    const Text("rebuilt!"),
                                    const CircularProgressIndicator()
                                  ],
                                ),
                              );
                            default:
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    const Text("refreshing today question.."),
                                    const CircularProgressIndicator()
                                  ],
                                ),
                              );
                          }
                        },
                      );
                    }
                    return Column(
                      children: [
                        Top(
                          group: snapshot.data!,
                        ),
                        GrowingTree(group: snapshot.data!),
                        Bottom(group: snapshot.data!),
                      ],
                    );
                  default:
                    return const CircularProgressIndicator();
                }
              }),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/Home.svg",
              width: 25,
              height: 25,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/Dashboard.svg",
                width: 25,
                height: 25,
              ),
              label: "리스트"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/Store.svg",
                width: 25,
                height: 25,
              ),
              label: "스토어"),
        ],
        currentIndex: _selectedIndex,
        selectedLabelStyle: textStyle.copyWith(
            fontWeight: FontWeightManager.medium,
            fontSize: FontSize.s16,
            height: 2),
        unselectedLabelStyle: textStyle.copyWith(
            fontWeight: FontWeightManager.medium, fontSize: FontSize.s16),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorManager.point,
      ),
    );
  }

  var textStyle = TextStyle(
    color: ColorManager.darkGrey,
    fontFamily: "GmarketSans",
    fontWeight: FontWeightManager.regular,
    fontSize: FontSize.s16,
  );
}

class Bottom extends StatelessWidget {
  const Bottom({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const BottomSheetBackground(),
        QuestionSheetWithAnswerButton(group: group),
      ],
    );
  }
}

class BottonSheetFrame extends StatelessWidget {
  const BottonSheetFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        color: ColorManager.white,
      ),
      child: child,
    );
  }
}

class QuestionSheetWithAnswerButton extends StatelessWidget {
  const QuestionSheetWithAnswerButton({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return BottonSheetFrame(
      child: Column(
        children: [
          QuestionSheet(group: group),
          const SizedBox(height: AppSize.s20),
          AnswerButton(
            group: group,
            onPressed: () {
              Get.toNamed(Routes.answerQuestionRoute);
            },
          ),
          const SizedBox(height: AppSize.s35),
        ],
      ),
    );
  }
}

class Top extends StatelessWidget {
  const Top({super.key, required this.group});
  final Group group;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const TopIconBar(),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 8),
              child: Text(
                group.groupName,
                style: getMediumStyle(
                  color: ColorManager.darkGrey,
                  fontSize: 20,
                ),
              ),
            ),
            Text(
              "${group.treeXp}p",
              style: getBoldStyle(
                color: ColorManager.darkGrey,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopIconBar extends StatelessWidget {
  const TopIconBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FambridgeIcon(),
        const SizedBox(width: 12),
        FittedBox(
          child: Text(
            "Fambridge",
            style: getBoldStyle(color: ColorManager.darkGrey, fontSize: 16),
          ),
        ),
        const Spacer(),
        Image.asset(ImageAssets.userProfile),
      ],
    );
  }
}

class FambridgeIcon extends StatelessWidget {
  const FambridgeIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.white,
      ),
      child: SvgPicture.asset(
        ImageAssets.homeLogo,
        width: 35,
        height: 35,
      ),
    );
  }
}

class profileFrameForSvg extends StatelessWidget {
  String asset;
  profileFrameForSvg({
    Key? key,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: IconButton(
        iconSize: 40,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: SvgPicture.asset(
          asset,
          width: 40,
          height: 40,
        ),
        onPressed: () {}, //do something,
      ),
    );
  }
}
