import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/service/auth/auth_exceptions.dart';
import 'package:fambridge/service/crud/group_exception.dart';
import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app.dart';
import '../../../app/constants/enums/family_role.dart';
import '../../../service/auth/auth_service.dart';
import '../../utilities/loading_dialog.dart';

class InputCodeTextField extends StatefulWidget {
  String hintText;
  TextEditingController controller;

  InputCodeTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<InputCodeTextField> createState() => _InputCodeTextFieldState();
}

class _InputCodeTextFieldState extends State<InputCodeTextField> {
  @override
  Widget build(BuildContext context) {
    var textStyle =
        TextStyle(fontFamily: 'GmarketSans', color: ColorManager.lightGrey);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorManager.lightGrey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 0), // changes position of shadow
          )
        ],
      ),
      child: TextField(
        controller: widget.controller,
        style: getMediumStyle(
          color: ColorManager.lightGrey,
          fontSize: 15,
        ),
        autofocus: false,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: textStyle,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          isDense: true,
          suffixIcon: IconButton(
          icon: Icon(Icons.send, color: ColorManager.point,),
          onPressed: onSubmitted,
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular((8)))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular((8)))),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular((8)))),
        ),
      ),
    );
  }

  Future<void> onSubmitted() async {
    
      var groupId = widget.controller.text == "" ? null : widget.controller.text;
      if(groupId == null) return;
      try {
        loadingDialog(context);
        if(!(await GroupService.firebase().isGroupExist(groupId: groupId))){
          throw GroupNotFoundGroupException();
        }
        final user = await AuthService.firebase().currentUser;
        await AuthService.firebase().addAuthToDatabase(
          groupId: groupId,
          authUser: user,
                    name: "shinhoo",
                    familyRole: FamilyRole.son,
                    birthOrder: 1,);
        await GroupService.firebase().addUserIntoGroup(groupId: groupId, userId: user!.id);
         MyApp.unsyncronizedAuthUser = await AuthService.firebase().currentUser;
        Get.back();
        Get.toNamed(Routes.secondDelayRoute);
      } on GroupNotFoundGroupException catch (_) {
        Get.back();
        Get.defaultDialog(
          title: "없는 가족 코드입니다.",
          titlePadding: const EdgeInsets.only(top: 40),
          titleStyle: getMediumStyle(
            color: ColorManager.darkGrey,
            fontSize: 18,
          ),
          middleText: "다시 확인해 보세요.",
          middleTextStyle: getMediumStyle(
            color: ColorManager.lightGrey,
            fontSize: 16,
          ),
          cancel: Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Text(
                "확인",
                style: getMediumStyle(
                  color: ColorManager.darkGrey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      } on UserNotLoggedInAuthException catch(_){
        Get.back();
        Get.defaultDialog(
          title: "계정 정보를 찾을 수 없습니다.",
          titlePadding: const EdgeInsets.only(top: 40),
          titleStyle: getMediumStyle(
            color: ColorManager.darkGrey,
            fontSize: 18,
          ),
          middleText: "다시 로그인 해 보세요.",
          middleTextStyle: getMediumStyle(
            color: ColorManager.lightGrey,
            fontSize: 16,
          ),
          cancel: Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Text(
                "확인",
                style: getMediumStyle(
                  color: ColorManager.darkGrey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      }
    
  }
}
