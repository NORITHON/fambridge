import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../resources/styles_manager.dart';

Future<dynamic> loadingDialog(BuildContext context) {
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
                  // The loading indicator
                  CircularProgressIndicator(
                    color: ColorManager.point
                  ),
                  const SizedBox(height: 29),
                  // Some text
                  Text('Loading...', style: getLightStyle(color: ColorManager.point,))
                ],
              ),
            ),
          ),
        );
      });
  }
