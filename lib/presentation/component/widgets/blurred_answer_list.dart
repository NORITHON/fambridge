import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';

import '../../../app/app.dart';
import '../../../app/constants/app_state_fieldname/group_state.dart';
import '../../../model/group.dart';
import '../../pages/home/home_view.dart';
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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p45),
            child: CommentBuilder(group: group),
          ),
          Visibility(
            visible: !GroupService.firebase()
                .checkIfAnswerCanBeVisualizable(group: group),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Align(
                alignment: const Alignment(0, -0.9),
                child: Text(
                    "${GroupService.firebase().requiredNumOfAnswersToVisualizeAnswers(group: group)}명만 더 대답하면 볼 수 있어요!"),
              ),
            ).asGlass(
              tintColor: Colors.transparent,
              clipBorderRadius: BorderRadius.circular(15.0),
            ),
          ),
          Visibility(
            visible: !GroupService.firebase()
                .checkIfAnswerCanBeVisualizable(group: group),
            child: BottonSheetFrame(
              child: !GroupService.firebase().hasUserAnsweredTodayQuestion(
                      group: group, userId: MyApp.unsyncronizedAuthUser!.id)
                  ? const AnswerFormBottomSheet()
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
