import 'package:flutter/material.dart';

import '../../../model/group.dart';
import '../../../service/auth/auth_service.dart';
import '../../../service/crud/group_service.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import 'answer_progress_indicator_with_title.dart';

class QuestionSheet extends StatefulWidget {
  const QuestionSheet({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  State<QuestionSheet> createState() => _QuestionSheetState();
}

class _QuestionSheetState extends State<QuestionSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Text(
          "#${widget.group.todayQuestion.questionOrder}",
          style: getMediumStyle(
            color: ColorManager.lightGrey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          widget.group.todayQuestion.question.questionScript,
          style: getMediumStyle(color: ColorManager.black, fontSize: 20),
        ),
        const SizedBox(height: 35),
        AnswerProgressIndicatorWithTitle(group: widget.group),
      ],
    );
  }
}
