import 'package:flutter/material.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

import '../../../model/group.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import 'answer_progress_indicator_with_title.dart';

class AnswerQuestionSheet extends StatefulWidget {
  const AnswerQuestionSheet({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  State<AnswerQuestionSheet> createState() => _AnswerQuestionSheetState();
}

class _AnswerQuestionSheetState extends State<AnswerQuestionSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Text(
          "#${widget.group.todayQuestion.questionOrder}",
          style: getMediumStyle(
            color: ColorManager.lightGrey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 240,
          child: WrappedKoreanText(
            textAlign: TextAlign.center,
            widget.group.todayQuestion.question.questionScript,
            style: getMediumStyle(color: ColorManager.black, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
