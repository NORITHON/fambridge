
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app.dart';
import '../../../app/constants/app_state_fieldname/question_state.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../view_model.dart';

class AnswerFormBottomSheet extends StatefulWidget {
  const AnswerFormBottomSheet({super.key});

  @override
  State<AnswerFormBottomSheet> createState() => _AnswerFormBottomSheetState();
}

class _AnswerFormBottomSheetState extends State<AnswerFormBottomSheet> {
  late final TextEditingController myAnswerTextEditinController;
  @override
  void initState() {
    super.initState();
    myAnswerTextEditinController = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    myAnswerTextEditinController.dispose();
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
                const SizedBox(height: AppPadding.p30,),
                Text("나의 대답", style: getMediumStyle(color: ColorManager.lightGrey, fontSize: AppSize.s14),),
                Flexible(
                  child: TextField(
                    onChanged: (script) {
                      MyApp.appState[questionStateFieldName]![userAnswerTextInputFieldName] = script;
                    },
                    controller: myAnswerTextEditinController,
                    maxLines: 5,
                    cursorColor: ColorManager.point,
                    style: getMediumStyle(color: ColorManager.darkGrey, fontSize: AppSize.s18),
                decoration:  InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 20),
                  hintText: "대답을 입력하세요.",
                  hintStyle: getMediumStyle(color: ColorManager.lightGrey, fontSize: AppSize.s18),
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
