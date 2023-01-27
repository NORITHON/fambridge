import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';

import '../../resources/values_manager.dart';
import '../homepage.dart';
import '../view_model.dart';
import 'answer_bottom_sheet.dart';
import 'answer_list.dart';

class BlurredAnswerList extends StatelessWidget {
  const BlurredAnswerList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p45),
            child: CommentBuilder(),
          ),
          GetBuilder<AnswerViewModel>(
            init: AnswerViewModel(),
            builder: (_) => Visibility(
              visible: !Get.find<AnswerViewModel>().isAnswerOpen.value,
              child: const SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Align(
                  alignment: Alignment(0, -0.9),
                  child: Text("1명만 더 대답하면 볼 수 있어요!"),
                ),
              ).asGlass(
                tintColor: Colors.transparent,
                clipBorderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          GetBuilder<AnswerViewModel>(
            init: AnswerViewModel(),
            builder: (_) => Visibility(
                visible: !Get.find<AnswerViewModel>().hasAnswered.value,
                child: const BottonSheetFrame(
                  child: AnswerFormBottomSheet(),
                )),
          ),
        ],
      ),
    );
  }
}
