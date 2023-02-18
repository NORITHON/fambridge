import 'package:flutter/material.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

import '../../../model/group.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class HomeQuestionSheet extends StatefulWidget {
  const HomeQuestionSheet({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  State<HomeQuestionSheet> createState() => _HomeQuestionSheetState();
}

class _HomeQuestionSheetState extends State<HomeQuestionSheet> {
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
          height: 50,
          width: 240,
          child: WrappedKoreanText(
            textAlign: TextAlign.center,
            widget.group.todayQuestion.question.questionScript,
            style: getMediumStyle(color: ColorManager.black, fontSize: 20),
          ),
        ),
        const SizedBox(height: 20),
        //AnswerProgressIndicatorWithTitle(group: widget.group),
      ],
    );
  }
}
