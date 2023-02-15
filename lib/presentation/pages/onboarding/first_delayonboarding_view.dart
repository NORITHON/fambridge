import 'dart:async';

import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/font_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class firstDelayView extends StatefulWidget {
  const firstDelayView({super.key});

  @override
  _firstDelayViewState createState() => _firstDelayViewState();
}

class _firstDelayViewState extends State<firstDelayView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Get.toNamed(Routes.numbersofFamilyRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: Container(
        color: ColorManager.backgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 250),
            Text(
              "2가지 질문에 답변을 통해.",
              textAlign: TextAlign.center,
              style: getMediumStyle(
                color: ColorManager.black,
                fontSize: FontSize.s16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "가족 코드가 발행됩니다.",
              textAlign: TextAlign.center,
              style: getMediumStyle(
                color: ColorManager.black,
                fontSize: FontSize.s16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _AppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
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
        elevation: 0,
      ),
    );
  }
}
