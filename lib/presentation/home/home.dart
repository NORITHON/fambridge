import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/service/auth/auth_service.dart';
import 'package:fambridge/service/group/group_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;

import '../../model/group_question.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String point = "326";
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
              const Tree(),
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

class _HomeTop extends StatelessWidget {
  const _HomeTop({
    Key? key,
    required this.textStyle,
  }) : super(key: key);

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
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
          child: SvgPicture.asset(
            ImageAssets.fambridgeIcon,
            width: AppSize.s40,
            height: AppSize.s40,
          ),
        ),
        const SizedBox(width: 15),
        Text(
          "Fambridge",
          style: textStyle,
        ),
        const SizedBox(width: 50),
        Container(
          padding: const EdgeInsets.all(0.0),
          child: IconButton(
            iconSize: AppSize.s40,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: SvgPicture.asset(
              ImageAssets.bookmark,
              width: AppSize.s40,
              height: AppSize.s40,
            ),
            onPressed: () {}, //do something,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(0.0),
          child: IconButton(
            iconSize: AppSize.s40,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: SvgPicture.asset(
              ImageAssets.profile,
              width: AppSize.s40,
              height: AppSize.s40,
            ),
            onPressed: () {
              Get.toNamed(Routes.myPageRoute);
            }, //do something,
          ),
        ),
      ],
    );
  }
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
        BottomGround(),
        BottomQuestion(),
      ],
    );
  }
}

class BottomQuestion extends StatefulWidget {
  const BottomQuestion({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomQuestion> createState() => _BottomQuestionState();
}

class _BottomQuestionState extends State<BottomQuestion> {
  @override
  void initState() {
    super.initState();
  }

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
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            "첫번째 질문",
            style: getMediumStyle(
              color: ColorManager.lightGrey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder(
            future: GroupService.firebase().getTodayGroupQuestion(
                groupId: AuthService.nonSyncronizedUser!.groupId!),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Text(snapshot.hasData
                      ? snapshot.data!.questionScript
                      : "no Data");
                default:
                  return CircularProgressIndicator(
                    color: ColorManager.buttonDisable,
                  );
              }
            },
          ),
          const SizedBox(height: 25),
          const AnswerProgressIndicatorWithTitle(),
          const SizedBox(height: 35),
          Container(
            width: 350,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.checkCommentRoute);
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "대답하기",
                      style: getMediumStyle(
                        color: ColorManager.white,
                        fontSize: 16,
                      ),
                    ),
                    const Icon(Icons.navigate_next),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnswerProgressIndicatorWithTitle extends StatelessWidget {
  const AnswerProgressIndicatorWithTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService.nonSyncronizedUser!.groupId;
    final totalCountFuture = GroupService.firebase().howManyPeopleInGroup(
        groupId: AuthService.nonSyncronizedUser!.groupId!);
    final answerCountFuture = GroupService.firebase().howManyPeopleAnswered(
        groupId: AuthService.nonSyncronizedUser!.groupId!);
    return FutureBuilder(
      future: Future.wait([totalCountFuture, answerCountFuture]),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final totalCount = snapshot.data?[0] ?? 0;
            final answerCount = snapshot.data?[1] ?? 0;
            return Column(
              children: [
                Text(
                  "$answerCount명이 답변했어요.",
                  style: getMediumStyle(
                    color: ColorManager.lightGrey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: AnswerProgressIndicator(
                      total: totalCount, count: answerCount),
                ),
              ],
            );
          default:
            return CircularProgressIndicator(
              color: ColorManager.point,
            );
        }
      },
    );
  }
}

class AnswerProgressIndicator extends StatelessWidget {
  const AnswerProgressIndicator(
      {super.key, required this.total, required this.count});

  final int total;
  final int count;

  Widget _getBar(bool isColored) {
    return Container(
      width: AppSize.s35,
      color: isColored ? ColorManager.point : ColorManager.lightGrey,
      height: AppSize.s3,
    );
  }

  Widget _getGap(bool isLockLocation) {
    return isLockLocation
        ? SvgPicture.asset(ImageAssets.lock)
        : const SizedBox(
            width: AppSize.s2,
          );
  }

  List<Widget> _getIndicatorBar() {
    final List<Widget> indicatorBar = [];
    int lockLocation = (total / 2).round();
    for (int i = 1; i <= total; i++) {
      indicatorBar.addAll([_getBar(i <= count), _getGap(i == lockLocation)]);
    }
    return indicatorBar;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _getIndicatorBar(),
    );
  }
}

class BottomGround extends StatelessWidget {
  const BottomGround({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          //배경 그라데이션 적용
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorManager.white,
            ColorManager.point,
          ],
        ),
      ),
    );
  }
}

class Tree extends StatefulWidget {
  const Tree({
    Key? key,
  }) : super(key: key);

  @override
  State<Tree> createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  bool get isPlaying => _controller?.isActive ?? false;

  rive.Artboard? _riveArtboard;
  rive.StateMachineController? _controller;
  rive.SMIInput<double>? _input;

  @override
  void initState() {
    super.initState();

    rootBundle.load(RiveAssets.growingThree).then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = rive.RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller =
            rive.StateMachineController.fromArtboard(artboard, 'GrowingTree');
        if (controller != null) {
          artboard.addController(controller);
          _input = controller.findInput('xpForTree');
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(
          child: _riveArtboard == null
              ? const SizedBox()
              : GestureDetector(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Slider(
                        value: _input!.value,
                        min: 0,
                        max: 100,
                        thumbColor: ColorManager.point,
                        activeColor: ColorManager.point,
                        inactiveColor: ColorManager.buttonDisable,
                        label: _input!.value.round().toString(),
                        onChanged: (double value) => setState(() {
                          _input!.value = value;
                        }),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: rive.Rive(
                          artboard: _riveArtboard!,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class Top extends StatelessWidget {
  String point = "326";

  Top({super.key});

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
            TopIconBar(),
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
            Text(
              "${point}p",
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
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            "Fambridge",
            style: getMediumStyle(color: ColorManager.darkGrey, fontSize: 16),
          ),
        ),
        const SizedBox(width: 50),
        SvgIcon(asset: ImageAssets.bookmark),
        SvgIcon(asset: ImageAssets.profile),
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
      child: SvgPicture.asset(
        ImageAssets.fambridgeIcon,
        width: 40,
        height: 40,
      ),
    );
  }
}

class SvgIcon extends StatelessWidget {
  String asset;
  SvgIcon({
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
