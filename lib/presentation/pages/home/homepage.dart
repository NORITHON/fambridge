import 'package:fambridge/app/app.dart';
import 'package:fambridge/model/group.dart';
import 'package:fambridge/presentation/component/logo/homelogo.dart';
import 'package:fambridge/presentation/component/profile/home_profile.dart';
import 'package:fambridge/presentation/component/widgets/answer_button.dart';
import 'package:fambridge/presentation/component/widgets/buttom_sheet_background.dart';
import 'package:fambridge/presentation/component/widgets/growing_tree.dart';
import 'package:fambridge/presentation/component/widgets/question_sheet.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/font_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyApp.unsyncronizedAuthUser == null
          ? const Center(
              child: Text("cannot find login info"),
            )
          : StreamBuilder<Group>(
              stream: GroupService.firebase()
                  .getGroup(groupId: MyApp.unsyncronizedAuthUser!.groupId!),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text("cannot find family group info"),
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
      height: 240,
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
          const SizedBox(height: AppSize.s35),
          AnswerButton(
            onPressed: () {
              Get.toNamed(Routes.answerQuestionRoute);
            },
          ),
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
            const TopBar(),
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

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HomelogoWithText(),
        const Spacer(),
        HomeProfile(),
      ],
    );
  }
}
