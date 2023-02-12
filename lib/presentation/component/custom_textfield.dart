import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextfield({
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
}
