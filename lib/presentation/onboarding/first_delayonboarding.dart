import 'package:fambridge/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';

class first_delayView extends StatefulWidget {
  const first_delayView({super.key});

  @override
  _first_delayState createState() => _first_delayState();
}

class _first_delayState extends State<first_delayView> {
  @override
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
            ],
          ),
        ),
      ),
    );
  }
}
