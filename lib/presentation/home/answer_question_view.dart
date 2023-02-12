import 'dart:async';

import 'package:fambridge/app/constants/app_state_fieldname/question_state.dart';
import 'package:fambridge/model/answer.dart';
import 'package:fambridge/presentation/home/widgets/question_sheet.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:fambridge/presentation/utilities/loading_dialog.dart';
import 'package:fambridge/service/auth/auth_service.dart';
import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../app/app.dart';
import '../../app/constants/app_state_fieldname/group_state.dart';
import '../../model/group.dart';
import '../common/group_stream_builder.dart';
import '../resources/assets_manager.dart';
import '../resources/getx_routes_manager.dart';
import 'view_model.dart';
import 'widgets/answer_button.dart';
import 'widgets/blurred_answer_list.dart';

class AnswerQuestionView extends StatefulWidget {
  const AnswerQuestionView({
    super.key,
  });

  @override
  State<AnswerQuestionView> createState() => _AnswerQuestionViewState();
}

class _AnswerQuestionViewState extends State<AnswerQuestionView> {
  @override
  Widget build(BuildContext context) {
    return GroupStreamBuilder(
      groupId: MyApp.unsyncronizedAuthUser!.groupId!,
      builder: (context, snapshot) => SafeArea(
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
            toolbarHeight: AppSize.s60,
            backgroundColor: ColorManager.backgroundColor,
            elevation: 1,
            shadowColor: ColorManager.shadowColor,
          ),
          body: Column(children: [
              QuestionSheet(group: snapshot.data!,),
              const SizedBox(
                height: AppPadding.p20,
              ),
              BlurredAnswerList(group: snapshot.data!),
          ],),
          floatingActionButton: Visibility(
            visible: !GroupService.firebase()
                .hasUserAnsweredTodayQuestion(group: snapshot.data!, userId: MyApp.unsyncronizedAuthUser!.id),
            child: AnswerButton(
              group: snapshot.data!,
              onPressed: () async {
                final String answerScript = MyApp.appState[questionStateFieldName]![userAnswerTextInputFieldName];
                if(answerScript.isEmpty) { 
                  return;
                }
                final answer = Answer(userId: MyApp.unsyncronizedAuthUser!.id, answerScript: answerScript, userName: MyApp.unsyncronizedAuthUser!.name);
                loadingDialog(context);
                await GroupService.firebase().submitAnswerForTodayQuestion(group: snapshot.data!, answer: answer);
                await GroupService.firebase().setTreeXp(group: snapshot.data!, setVal: 1);
                await GroupService.firebase().makeTodayQuestionAnswerVisualizable(group: snapshot.data!);
                Get.offAllNamed(Routes.homeRoute);
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}