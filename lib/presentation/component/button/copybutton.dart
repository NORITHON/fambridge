import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Copybutton extends StatelessWidget {
  const Copybutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 147,
          height: 57,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.point,
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              //가족이 다 모였다면
              Clipboard.setData(const ClipboardData(text: "24983827"));
              //아직 다 모이지 않았다면
              //Get.toNamed(Routes.codeshareRoute);
            },
            child: Text(
              "복사하기",
              style: getRegularStyle(color: ColorManager.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
