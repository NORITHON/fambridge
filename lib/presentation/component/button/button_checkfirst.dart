import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonCheckfirst extends StatelessWidget {
  const ButtonCheckfirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 240,
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
              Get.toNamed(Routes.numbersofFamilyRoute);
              //아직 다 모이지 않았다면
              //Get.toNamed(Routes.codeshareRoute);
            },
            child: Text(
              "확인",
              style: getRegularStyle(color: ColorManager.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
