import 'dart:developer';
import 'dart:ui';

import 'package:fambridge/presentation/home/widgets/answer_progress_indicator.dart';
import 'package:fambridge/presentation/home/widgets/question_sheet.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/strings_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:fambridge/service/auth/auth_service.dart';
import 'package:fambridge/service/group/group_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../resources/assets_manager.dart';
import '../utilities/msg_alert_dialog.dart';
import 'view_model.dart';
import 'widgets/answer_button.dart';
import 'widgets/blurred_answer_list.dart';

class AnswerQuestionView extends StatefulWidget {
  const AnswerQuestionView({super.key});

  @override
  State<AnswerQuestionView> createState() => _AnswerQuestionViewState();
}

class _AnswerQuestionViewState extends State<AnswerQuestionView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset(
              ImageAssets.back,
              height: 20,
              width: 20,
              fit: BoxFit.scaleDown,
            ),
          ),
          title: const Text("질문"),
          toolbarHeight: AppSize.s100,
          backgroundColor: ColorManager.backgroundColor,
          elevation: 1,
          shadowColor: ColorManager.shadowColor,
        ),
        body: Column(children: const [
          QuestionSheet(),
          SizedBox(
            height: AppPadding.p20,
          ),
          BlurredAnswerList(),
        ]),
        floatingActionButton: GetBuilder<AnswerViewModel>(
          init: AnswerViewModel(),
          builder: (_) => Visibility(
<<<<<<< HEAD
          visible: !Get.find<AnswerViewModel>().hasAnswered.value,
          child: AnswerButton(
            onPressed: () async {
              await GroupService.firebase().submitAnswerForGroupQuestion(groupId: AuthService.nonSyncronizedUser!.groupId!, answerScript: Get.find<AnswerViewModel>().answerScript.value, userId: AuthService.nonSyncronizedUser!.id);
              final newVal = await GroupService.firebase().checkIfAnswerShouldBeOpen(groupId: AuthService.nonSyncronizedUser!.groupId!);
              if(newVal ?? false) await msgAlertDialog(context, title: AppStrings.answerOpened, body: AppStrings.checkTheAnswers);
              Get.find<AnswerViewModel>().setHasAnswered(newVal: true, listen: true);
              Get.find<AnswerViewModel>().setIsAnswerOpen(newVal: newVal, listen: true);
              
            },
=======
            visible: !Get.find<AnswerViewModel>().hasAnswered.value,
            child: AnswerButton(
              onPressed: () async {
                await GroupService.firebase().submitAnswerForGroupQuestion(
                    groupId: AuthService.nonSyncronizedUser!.groupId!,
                    answerScript:
                        Get.find<AnswerViewModel>().answerScript.value,
                    userId: AuthService.nonSyncronizedUser!.id);
                final newVal = await GroupService.firebase()
                    .checkIfAnswerShouldBeOpen(
                        groupId: AuthService.nonSyncronizedUser!.groupId!);
                Get.find<AnswerViewModel>()
                    .setHasAnswered(newVal: true, listen: true);
                Get.find<AnswerViewModel>()
                    .setIsAnswerOpen(newVal: newVal, listen: true);
              },
            ),
>>>>>>> a7967d64c42289d0967738f8563e835df9b91d42
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
