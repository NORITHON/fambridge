import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class HomeTilte extends StatelessWidget {
  const HomeTilte({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: ColorManager.white,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              '#1',
              style:
                  getRegularStyle(color: ColorManager.lightGrey, fontSize: 14),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 220,
              child: Text(
                '인생에서 가장 큰 가치는 무엇인가요?',
                style: getRegularStyle(color: ColorManager.black, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 35,
            )
          ],
        ),
      ),
    );
  }
}
