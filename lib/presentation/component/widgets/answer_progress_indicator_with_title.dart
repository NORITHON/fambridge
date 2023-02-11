import 'package:flutter/material.dart';
import '../../../model/group.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import 'answer_progress_indicator.dart';

class AnswerProgressIndicatorWithTitle extends StatelessWidget {
  const AnswerProgressIndicatorWithTitle({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    final totalCount = group.userIdsInGroup.length;
    final answerCount = group.todayQuestion.answers.length;
    return Column(
      children: [
        Text(
          "$answerCount명이 답변했어요.",
          style: getMediumStyle(
            color: ColorManager.lightGrey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: AnswerProgressIndicator(total: totalCount, count: answerCount),
        ),
      ],
    );
  }
}
