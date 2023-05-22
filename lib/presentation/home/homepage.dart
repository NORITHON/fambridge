import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/splash/splash.dart';
import 'package:fambridge/service/auth/auth_service.dart';
import 'package:fambridge/service/group/group_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../resources/font_manager.dart';
import '../resources/values_manager.dart';
import 'widgets/answer_button.dart';
import 'widgets/buttom_sheet_background.dart';
import 'widgets/growing_tree.dart';
import 'widgets/question_sheet.dart';

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
      body: SafeArea(
        child: Container(
          color: ColorManager.white,
          child: Column(
            children: [
              Top(),
              const GrowingTree(),
              const Bottom(),
            ],
          ),
        ),
      ),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: const [
        BottomSheetBackground(),
        QuestionSheetWithAnswerButton(),
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
  const QuestionSheetWithAnswerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BottonSheetFrame(
        child: Column(
      children: [
        const QuestionSheet(),
        const SizedBox(height: AppSize.s35),
        AnswerButton(onPressed: () {
          Get.toNamed(Routes.answerQuestionRoute);
        }),
      ],
    ));
  }
}

class Top extends StatelessWidget {
  final String point = "326";

  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              "'우리'나무",
              style: getMediumStyle(
                color: ColorManager.darkGrey,
                fontSize: 20,
              ),
            ),
          ),
          FutureBuilder(
            future: GroupService.firebase()
                .getTreeXp(groupId: AuthService.nonSyncronizedUser!.groupId!),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Text(
                    "${snapshot.data}p",
                    style: getBoldStyle(
                      color: ColorManager.darkGrey,
                      fontSize: 20,
                    ),
                  );
                default:
                  return CircularProgressIndicator(
                    color: ColorManager.point,
                  );
              }
            },
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
        const SizedBox(width: 15),
        FittedBox(
          child: Text(
            "Fambridge",
            style: getMediumStyle(color: ColorManager.darkGrey, fontSize: 16),
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              AuthService.firebase().logOut();
              Get.offAllNamed(Routes.loginRoute);
            },
            icon: const Icon(Icons.logout))
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
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.darkGrey.withOpacity(0.25),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: const AppLogo(
        size: AppSize.s40,
      ),
    );
  }
}

class profileFrameForSvg extends StatelessWidget {
  final String asset;
  const profileFrameForSvg({
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
