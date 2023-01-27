import 'dart:ffi';

import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../resources/font_manager.dart';

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

  var textStyle = TextStyle(
    color: ColorManager.darkGrey,
    fontFamily: "GmarketSans",
    fontWeight: FontWeightManager.regular,
    fontSize: FontSize.s16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ColorManager.white,
          child: Column(
            children: [
              Top(),
              Tree(),
              Bottom(),
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
            width: 40,
            height: 40,
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
            iconSize: 40,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: SvgPicture.asset(
              ImageAssets.bookmark,
              width: 40,
              height: 40,
            ),
            onPressed: () {}, //do something,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(0.0),
          child: IconButton(
            iconSize: 40,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: SvgPicture.asset(
              ImageAssets.profile,
              width: 40,
              height: 40,
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
      children: [
        BottomGround(),
        BottomQuestion(),
      ],
    );
  }
}

class BottomQuestion extends StatelessWidget {
  const BottomQuestion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        color: ColorManager.white,
      ),
      child: Column(
        children: [
          SizedBox(height: 15),
          Text(
            "첫번째 질문",
            style: getMediumStyle(
              color: ColorManager.lightGrey,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "\"우리는 어떤 가족인가요?\"",
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 25),
          Text(
            "2명이 답변했어요.",
            style: getMediumStyle(
              color: ColorManager.lightGrey,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 12345.toString().split("").map((e) {
              return Row(
                children: [
                  Container(
                    width: 35,
                    color: int.parse(e) < 3
                        ? ColorManager.point
                        : ColorManager.lightGrey,
                    height: 3,
                  ),
                  e == '3'
                      ? SvgPicture.asset(ImageAssets.lock)
                      : SizedBox(
                          width: 2,
                        ),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 35),
          Container(
            width: 350,
            child: ElevatedButton(
              onPressed: () {},
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
                    Icon(Icons.navigate_next),
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

class Tree extends StatelessWidget {
  const Tree({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(
          child: Text("Tree"),
        ),
      ),
    );
  }
}

class Top extends StatelessWidget {
  String point = "326";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            TopIconBar(),
            SizedBox(height: 25),
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FambridgeIcon(),
        SizedBox(width: 15),
        Expanded(
          child: Text(
            "Fambridge",
            style: getMediumStyle(color: ColorManager.darkGrey, fontSize: 16),
          ),
        ),
        SizedBox(width: 50),
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
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.darkGrey.withOpacity(0.25),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(1, 1),
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
        constraints: BoxConstraints(),
        icon: SvgPicture.asset(
          ImageAssets.bookmark,
          width: 40,
          height: 40,
        ),
        onPressed: () {}, //do something,
      ),
    );
  }
}
