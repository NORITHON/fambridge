import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../resources/styles_manager.dart';

SnackBar mySnackBar({required String text, required Widget icon}) {
  return SnackBar(
    padding: const EdgeInsets.symmetric(vertical: 14),
    backgroundColor: ColorManager.backgroundColor,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(50),
    elevation: 10,
    duration: const Duration(milliseconds: 3000),
    shape: OutlineInputBorder(
      borderSide: BorderSide(color: ColorManager.primary),
      borderRadius: BorderRadius.circular(13),
    ),
    content: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: icon,
        ),
        Text(
          text,
          style: getRegularStyle(color:ColorManager.black)
        ),
      ],
    ),
  );
}
