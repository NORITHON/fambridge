
import 'package:fambridge/presentation/pages/feedback_page/feedback_page.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class DictionaryAddButton extends StatelessWidget {
  const DictionaryAddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Get.toNamed(Routes.feedbackPages),
      child: Text(
        '피드백',
        style: TextStyle(color: ColorManager.primary,),
      ),
    );
  }
}
