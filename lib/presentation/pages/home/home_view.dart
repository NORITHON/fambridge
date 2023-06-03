// ignore_for_file: unnecessary_const

import 'dart:developer';

import 'package:fambridge/app/app.dart';
import 'package:fambridge/model/group.dart';
import 'package:fambridge/presentation/component/button/navigate_to_feedback.dart';
import 'package:fambridge/presentation/component/widgets/answer_button.dart';
import 'package:fambridge/presentation/component/widgets/buttom_sheet_background.dart';
import 'package:fambridge/presentation/component/widgets/growing_tree.dart';
import 'package:fambridge/presentation/component/widgets/home_question_sheet.dart';
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
  void _onItemTapped(int index) {
    setState(() {});
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
      appBar: AppBar(actions: const [DictionaryAddButton()]),
      body: MyApp.unsyncronizedAuthUser == null
          ? const Center(
              child: Text("cannot find login info"),
            )
          : GroupStreamBuilder(
              groupId: MyApp.unsyncronizedAuthUser!.groupId!,
              builder: (context, data) {
                if (GroupService.firebase().shouldReplaceTodayQuestion(
                    group: data, user: MyApp.unsyncronizedAuthUser!)) {
                  return FutureBuilder(
                    future: GroupService.firebase()
                        .replaceTodayQuestionToTheNextQuestion(group: data),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text("rebuilt!"),
                                CircularProgressIndicator()
                              ],
                            ),
                          );
                        default:
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text("refreshing today question.."),
                                CircularProgressIndicator()
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
                      group: data,
                    ),
                    GrowingTree(group: data),
                    Bottom(group: data),
                  ],
                );
              }),
      // bottomNavigationBar: CustomBottomNavbar(
      //   selectedIndex: _selectedIndex,
      //   onItemTapped: _onItemTapped,
      // ),
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

class HomeBottonSheetFrame extends StatelessWidget {
  const HomeBottonSheetFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorManager.darkGrey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(1, 1),
          ),
        ],
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
    return HomeBottonSheetFrame(
      child: Column(
        children: [
          HomeQuestionSheet(group: group),
          const SizedBox(height: AppSize.s20),
          AnswerButton(
            group: group,
            onPressed: () {
              Get.toNamed(Routes.answerQuestionRoute);
            },
          ),
          const SizedBox(height: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TopIconBar(),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                group.groupName,
                style: getMediumStyle(
                  color: ColorManager.darkGrey,
                  fontSize: 20,
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
        ],
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
        IconButton(
          onPressed: () {
            AuthService.firebase().logOut();
            Get.offAllNamed(Routes.loginRoute);
          },
          icon: const Icon(
            Icons.logout,
          ),
        ),
        SvgPicture.asset(
          ImageAssets.profile,
          width: 40,
          height: 40,
        ),
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
