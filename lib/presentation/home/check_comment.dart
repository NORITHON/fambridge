import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/strings_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../resources/color_manager.dart';

class CheckCommentView extends StatefulWidget {
  const CheckCommentView({super.key});

  @override
  State<CheckCommentView> createState() => _CheckCommentViewState();
}

class _CheckCommentViewState extends State<CheckCommentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: Container(
        child: Column(
          children: [
            Top(),
            CommentBuilder(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: EdgeInsets.all(0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(Routes.homeRoute);
                },
                child: const Text(
                  "나가기",
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _AppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        title: Text(
          "질문",
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
        elevation: 1,
      ),
    );
  }
}

class CommentBuilder extends StatelessWidget {
  const CommentBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
        child: ListView.separated(
          itemBuilder: ((context, index) {
            return Comment();
          }),
          separatorBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Container(
                height: 2,
                color: ColorManager.white,
              ),
            );
          }),
          itemCount: 5,
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  const Comment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleProfile(size: 25),
              SizedBox(width: 10),
              Text(
                "첫째",
                style: getMediumStyle(
                  color: ColorManager.lightGrey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 0),
            child: Text("서로에게 무관심하나 마음만은 서로를 향해있는 가족",
                style: getMediumStyle(
                  color: ColorManager.lightGrey,
                  fontSize: 16,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleProfile(size: 30),
              CircleProfile(size: 30),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SvgPicture.asset(ImageAssets.likeOn),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircleProfile extends StatelessWidget {
  double size;
  CircleProfile({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.transparent,
      ),
      child: SvgPicture.asset(
        ImageAssets.onboardingLogo1,
        height: size,
        width: size,
        allowDrawingOutsideViewBox: true,
      ),
    );
  }
}

class Top extends StatelessWidget {
  const Top({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ColorManager.black,
            blurRadius: 10,
            spreadRadius: -10,
            offset: Offset(0.0, 3),
          )
        ],
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
            "답변이 열렸어요!",
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
                    color: int.parse(e) < 4
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
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
