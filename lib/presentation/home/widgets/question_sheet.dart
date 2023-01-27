
import 'package:flutter/material.dart';

import '../../../service/auth/auth_service.dart';
import '../../../service/group/group_service.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import 'answer_progress_indicator_with_title.dart';

class QuestionSheet extends StatefulWidget {
  const QuestionSheet({
    Key? key,
  }) : super(key: key);

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
          "첫번째 질문",
          style: getMediumStyle(
            color: ColorManager.lightGrey,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        FutureBuilder(
          future: GroupService.firebase().getTodayGroupQuestion(
              groupId: AuthService.nonSyncronizedUser!.groupId!),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Text(snapshot.hasData
                    ? snapshot.data!.questionScript
                    : "no Data",
                    style: getMediumStyle(color: ColorManager.black, fontSize: 20),
                );
              default:
                return CircularProgressIndicator(
                  color: ColorManager.buttonDisable,
                );
            }
          },
        ),
        const SizedBox(height: 25),
        const AnswerProgressIndicatorWithTitle(),
      ],
    );
  }
}
