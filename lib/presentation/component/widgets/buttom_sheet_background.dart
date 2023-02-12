import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';

class BottomSheetBackground extends StatelessWidget {
  const BottomSheetBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          //배경 그라데이션 적용
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorManager.white,
            ColorManager.point,
          ],
        ),
      ),
    );
  }
}
