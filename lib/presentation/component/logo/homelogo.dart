import 'package:fambridge/presentation/pages/home/home_view.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class HomelogoWithText extends StatelessWidget {
  const HomelogoWithText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const FambridgeIcon(),
          const SizedBox(width: 12),
          FittedBox(
            child: Text(
              "Fambridge",
              style: getBoldStyle(
                color: ColorManager.darkGrey,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
