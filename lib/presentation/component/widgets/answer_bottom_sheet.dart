import 'package:fambridge/controller/my_answer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../app/app.dart';
import '../../../app/constants/app_state_fieldname/question_state.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class AnswerFormBottomSheet extends StatefulWidget {
  const AnswerFormBottomSheet({
    super.key,
  });

  @override
  State<AnswerFormBottomSheet> createState() => _AnswerFormBottomSheetState();
}

class _AnswerFormBottomSheetState extends State<AnswerFormBottomSheet> {
  var myAnswerController = Get.put(MyAnswerController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height * .5;
    return SizedBox(
      height: maxHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppPadding.p30,
            ),
            Text(
              "나의 대답",
              style: getMediumStyle(
                  color: ColorManager.lightGrey, fontSize: AppSize.s14),
            ),
            Flexible(
              child: TextField(
                onChanged: (script) {
                  MyApp.appState[questionStateFieldName]![
                      userAnswerTextInputFieldName] = script;
                  myAnswerController.setuserAnswerTextInput(script);
                },
                maxLines: 5,
                cursorColor: ColorManager.point,
                style: getMediumStyle(
                    color: ColorManager.darkGrey, fontSize: AppSize.s18),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 30),
                  hintText: "여기를 클릭해 작성해주세요.",
                  hintStyle: getMediumStyle(
                      color: ColorManager.darkGrey, fontSize: AppSize.s18),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
