import 'package:fambridge/app/app.dart';
import 'package:fambridge/app/constants/app_state_fieldname/question_state.dart';
import 'package:fambridge/controller/my_answer_controller.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../model/group.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class QuestionAnswerButton extends StatelessWidget {
  const QuestionAnswerButton({
    Key? key,
    required this.onPressed,
    required this.group,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Group group;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.white,
      ),
      child: Obx(
        () {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Get.find<MyAnswerController>().userAnswerTextInput.value != ""
                  ? Text(
                      "작성 완료!",
                      style: getMediumStyle(
                          color: ColorManager.lightGrey, fontSize: AppSize.s12),
                    )
                  : const SizedBox(),
              Get.find<MyAnswerController>().userAnswerTextInput.value == ""
                  ? SvgPicture.asset(
                      ImageAssets.homeAnswerYet,
                      height: 70,
                      width: 70,
                    )
                  : IconButton(
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        ImageAssets.homeAnswerDone,
                      ),
                      iconSize: 70,
                      onPressed: onPressed //do something,
                      ),
            ],
          );
        },
      ),

      // width: 350,
      // child: ElevatedButton(
      //   onPressed: onPressed,
      //   child: Padding(
      //     padding: const EdgeInsets.all(15),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text(
      //           GroupService.firebase().hasUserAnsweredTodayQuestion(
      //                   group: group, userId: MyApp.unsyncronizedAuthUser!.id)
      //               ? "대답보기"
      //               : "대답하기",
      //           style: getMediumStyle(
      //             color: ColorManager.white,
      //             fontSize: 16,
      //           ),
      //         ),
      //         const Icon(Icons.navigate_next),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
