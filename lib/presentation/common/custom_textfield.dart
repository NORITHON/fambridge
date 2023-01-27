import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/service/group/group_exception.dart';
import 'package:fambridge/service/group/group_provider.dart';
import 'package:fambridge/service/group/group_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextfield extends StatefulWidget {
  String hintText;
  TextEditingController controller;

  CustomTextfield({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
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
            offset: Offset(0, 0), // changes position of shadow
          )
        ],
      ),
      child: TextField(
        maxLength: 5,
        onChanged: onChanged,
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
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular((8)))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular((8)))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular((8)))),
        ),
      ),
    );
  }

  void onChanged(value) async {
    print(widget.controller.text);
    //db에 widget.controller.text값이 존재하는지 확인하는 조건 추가.

    if (widget.controller.text.length == 5) {
      var groupId = widget.controller.text;
      try {
        var result = await GroupService.firebase().getGroup(groupId: groupId);
        Get.toNamed(Routes.secondDelayRoute);
      } on GroupNotFoundGroupException catch (e) {
        Get.defaultDialog(
          title: "없는 가족 코드입니다.",
          titlePadding: EdgeInsets.only(top: 40),
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
      }
    }
  }
}
