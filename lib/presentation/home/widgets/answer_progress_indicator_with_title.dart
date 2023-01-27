import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../service/auth/auth_service.dart';
import '../../../service/group/group_service.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../view_model.dart';
import 'answer_progress_indicator.dart';

class AnswerProgressIndicatorWithTitle extends StatelessWidget {
  const AnswerProgressIndicatorWithTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService.nonSyncronizedUser!.groupId;
    return GetBuilder<AnswerViewModel>(
        init: AnswerViewModel(),
        builder: (answerViewModel) {
          Get.find<AnswerViewModel>().answerScript;
          final totalCountFuture = GroupService.firebase().howManyPeopleInGroup(
              groupId: AuthService.nonSyncronizedUser!.groupId!);
          final answerCountFuture = GroupService.firebase()
              .howManyPeopleAnswered(
                  groupId: AuthService.nonSyncronizedUser!.groupId!);
          return FutureBuilder(
            future: Future.wait([totalCountFuture, answerCountFuture]),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final totalCount = snapshot.data?[0] ?? 0;
                  final answerCount = snapshot.data?[1] ?? 0;
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
                        child: AnswerProgressIndicator(
                            total: totalCount, count: answerCount),
                      ),
                    ],
                  );
                default:
                  return CircularProgressIndicator(
                    color: ColorManager.point,
                  );
              }
            },
          );
        });
  }
}
