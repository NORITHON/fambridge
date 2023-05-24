import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class Sharebutton extends StatelessWidget {
  final String data;

  const Sharebutton({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 147,
          height: 57,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.white,
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: ColorManager.point),
              ),
            ),
            onPressed: () {
              //가족이 다 모였다면
              Share.share(data);
              //아직 다 모이지 않았다면
              //Get.toNamed(Routes.codeshareRoute);
            },
            child: Text(
              "공유하기",
              style: getRegularStyle(color: ColorManager.point, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
