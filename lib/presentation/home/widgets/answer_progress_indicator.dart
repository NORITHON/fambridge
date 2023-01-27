
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class AnswerProgressIndicator extends StatelessWidget {
  const AnswerProgressIndicator(
      {super.key, required this.total, required this.count});

  final int total;
  final int count;

  Widget _getBar(bool isColored) {
    return Container(
      width: AppSize.s35,
      color: isColored ? ColorManager.point : ColorManager.lightGrey,
      height: AppSize.s3,
    );
  }

  Widget _getGap(bool isLockLocation) {
    return isLockLocation
        ? SvgPicture.asset(ImageAssets.lock)
        : const SizedBox(
            width: AppSize.s2,
          );
  }

  List<Widget> _getIndicatorBar() {
    final List<Widget> indicatorBar = [];
    int lockLocation = (total / 2).round();
    for (int i = 1; i <= total; i++) {
      indicatorBar.addAll([_getBar(i <= count), _getGap(i == lockLocation)]);
    }
    return indicatorBar;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _getIndicatorBar(),
    );
  }
}
