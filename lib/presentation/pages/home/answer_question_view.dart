import 'package:fambridge/app/constants/app_state_fieldname/question_state.dart';
import 'package:fambridge/model/answer.dart';
import 'package:fambridge/presentation/component/widgets/answer_question_sheet.dart';
import 'package:fambridge/presentation/component/widgets/question_answer_button.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:fambridge/presentation/utilities/loading_dialog.dart';
import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../app/app.dart';
import '../../component/group_stream_builder.dart';
import '../../resources/assets_manager.dart';
import '../../resources/getx_routes_manager.dart';
import '../../component/widgets/blurred_answer_list.dart';

class AnswerQuestionView extends StatefulWidget {
  const AnswerQuestionView({
    super.key,
  });

  @override
  State<AnswerQuestionView> createState() => _AnswerQuestionViewState();
}

class _AnswerQuestionViewState extends State<AnswerQuestionView> {
  final myAnswerTextEditinController = TextEditingController();

  @override
  void dispose() {
    myAnswerTextEditinController.dispose();
    super.dispose();
  }

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
            elevation: 7,
            shadowColor: ColorManager.shadowColor,
          ),
          body: Container(
            color: ColorManager.white,
            child: Column(
              children: [
                AnswerQuestionSheet(
                  group: snapshot.data!,
                ),
                const SizedBox(
                  height: AppPadding.p30,
                ),
                BlurredAnswerList(
                  group: snapshot.data!,
                ),
              ],
            ),
          ),
          floatingActionButton: _FloatingActionButton(
              snapshot: snapshot,
              myAnswerTextEditinController: myAnswerTextEditinController),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton({
    Key? key,
    required this.snapshot,
    required this.myAnswerTextEditinController,
  }) : super(key: key);

  final AsyncSnapshot snapshot;
  final TextEditingController myAnswerTextEditinController;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !GroupService.firebase().hasUserAnsweredTodayQuestion(
          group: snapshot.data!, userId: MyApp.unsyncronizedAuthUser!.id),
      child: QuestionAnswerButton(
        group: snapshot.data!,
        onPressed: () async {
          final String answerScript = MyApp
              .appState[questionStateFieldName]![userAnswerTextInputFieldName];
          if (answerScript.isEmpty) {
            return;
          }
          final answer = Answer(
              userId: MyApp.unsyncronizedAuthUser!.id,
              answerScript: answerScript,
              userName: MyApp.unsyncronizedAuthUser!.name);
          loadingDialog(context);
          await GroupService.firebase().submitAnswerForTodayQuestion(
              group: snapshot.data!, answer: answer);
          await GroupService.firebase()
              .setTreeXp(group: snapshot.data!, setVal: 1);
          await GroupService.firebase()
              .makeTodayQuestionAnswerVisualizable(group: snapshot.data!);
          Get.offAllNamed(Routes.buildPages);
        },
      ),
    );
  }
}
