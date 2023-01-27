import 'package:fambridge/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';

class second_delayView extends StatefulWidget {
  const second_delayView({super.key});

  @override
  _second_delayState createState() => _second_delayState();
}

class _second_delayState extends State<second_delayView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
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
              const FamilyList(),
              const SizedBox(
                height: 50,
              ),
              Text(
                "가장 가깝지만 멀었던",
                textAlign: TextAlign.center,
                style: getMediumStyle(
                  color: ColorManager.point,
                  fontSize: FontSize.s16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "'우리'를 알아가는 시간을 보내세요",
                textAlign: TextAlign.center,
                style: getMediumStyle(
                  color: ColorManager.point,
                  fontSize: FontSize.s16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FamilyList extends StatelessWidget {
  const FamilyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '아빠',
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 16,
            ),
          ),
          Text(
            '엄마',
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 16,
            ),
          ),
          Text(
            '첫째',
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 16,
            ),
          ),
          Text(
            '뚤째',
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 16,
            ),
          ),
          Text(
            '셋째',
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
