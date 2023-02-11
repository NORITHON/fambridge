import 'package:fambridge/presentation/component/question/list_title.dart';
import 'package:fambridge/presentation/component/widgets/answer_button.dart';
import 'package:fambridge/presentation/component/widgets/blurred_answer_list.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'view_model.dart';

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
        body: const Column(children: [
          ListTitle(),
          //QuestionSheet(),
          SizedBox(
            height: AppPadding.p20,
          ),
          BlurredAnswerList(),
        ]),
        floatingActionButton: GetBuilder<AnswerViewModel>(
          init: AnswerViewModel(),
          builder: (_) => Visibility(
            visible: !Get.find<AnswerViewModel>().hasAnswered.value,
            child: AnswerButton(
              onPressed: () async {
                //await GroupService.firebase().submitAnswerForTodayQuestion(groupId: AuthService.nonSyncronizedUser!.groupId!, answerScript: Get.find<AnswerViewModel>().answerScript.value, userId: AuthService.nonSyncronizedUser!.id);
                //final newVal = await GroupService.firebase().checkIfAnswerShouldBeOpen(familyGroupId: AuthService.nonSyncronizedUser!.groupId!);
                //Get.find<AnswerViewModel>().setIsAnswerOpen(newVal: newVal, listen: true);
                //Get.find<AnswerViewModel>().setHasAnswered(newVal: true, listen: true);
              },
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
