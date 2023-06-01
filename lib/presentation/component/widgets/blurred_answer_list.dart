import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/component/button/home_answer_back.dart';
import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';

import '../../../app/app.dart';
import '../../../model/group.dart';
import '../../resources/getx_routes_manager.dart';
import '../../resources/values_manager.dart';
import 'answer_bottom_sheet.dart';
import 'answer_list.dart';

class BlurredAnswerList extends StatelessWidget {
  const BlurredAnswerList({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: ColorManager.questionbackgroundColor,
        padding: const EdgeInsets.only(top: 16),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppPadding.p35, AppPadding.p18,
                  AppPadding.p35, AppPadding.p16),
              child: CommentBuilder(group: group),
            ),
            Visibility(
              visible: !GroupService.firebase()
                  .checkIfAnswerCanBeVisualizable(group: group),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Align(
                  alignment: const Alignment(0, -1),
                  child: AnswerNotYet(group: group),
                ),
              ).asGlass(
                tintColor: Colors.transparent,
                clipBorderRadius: BorderRadius.circular(15.0),
              ),
            ),
            Visibility(
              visible: !GroupService.firebase()
                  .checkIfAnswerCanBeVisualizable(group: group),
              child: AnswerBottonSheetFrame(
                child: !GroupService.firebase().hasUserAnsweredTodayQuestion(
                        group: group, userId: MyApp.unsyncronizedAuthUser!.id)
                    ? const AnswerFormBottomSheet()
                    : Container(),
              ),
            ),
            Visibility(
              visible: GroupService.firebase()
                  .checkIfAnswerCanBeVisualizable(group: group),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: HomeAnswerBack(
                  onPressed: () {
                    Get.offAllNamed(Routes.buildPages);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnswerNotYet extends StatelessWidget {
  const AnswerNotYet({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          ImageAssets.answerNotYet,
          width: 20,
          height: 20,
        ),
        Text(
          " ${GroupService.firebase().requiredNumOfAnswersToVisualizeAnswers(group: group)}명만 더 대답하면 볼 수 있어요!",
          style: getMediumStyle(color: ColorManager.lightGrey, fontSize: 12),
        ),
      ],
    );
  }
}

class AnswerBottonSheetFrame extends StatelessWidget {
  const AnswerBottonSheetFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: ColorManager.point,
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        color: ColorManager.white,
      ),
      child: child,
    );
  }
}
