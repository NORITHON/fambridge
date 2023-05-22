import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../resources/styles_manager.dart';

Future<dynamic> msgAlertDialog(BuildContext context,
    {String? title, required String body}) {
  return showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: ColorManager.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 210,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: title != null,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        title!,
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: AppSize.s18,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      body,
                      style: getMediumStyle(
                        color: ColorManager.darkGrey,
                        fontSize: AppSize.s16,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("확인"),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
