import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:fk_toggle/fk_toggle.dart';

class numbersofFamilyView extends StatefulWidget {
  const numbersofFamilyView({super.key});

  @override
  _numbersofFamilyState createState() => _numbersofFamilyState();
}

var textStyle = const TextStyle(
  fontFamily: 'GmarketSans',
  fontSize: 16,
);
var pointStyle = TextStyle(
  color: ColorManager.point,
  fontFamily: 'GmarketSans',
);

class _numbersofFamilyState extends State<numbersofFamilyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _MypageAppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 110),
              Text(
                "가족 구성원은 몇 명인가요?",
                textAlign: TextAlign.left,
                style: textStyle,
              ),
              const SizedBox(height: 50),
              Center(
                child:
                    FkToggle(width: 50, height: 30, labels: const ['2명', '3명']),
              ),
              Center(
                child: FkToggle(
                    width: 50,
                    height: 30,
                    labels: const ['4명', '5명', '6명', '7명']),
              ),
              Center(
                child: FkToggle(
                    width: 50, height: 30, labels: const ['8명', '9명', '10명']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget _MypageAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      title: Text(
        "",
        style: getMediumStyle(
          fontSize: 18,
          color: ColorManager.darkGrey,
        ),
      ),
      centerTitle: true,
      backgroundColor: ColorManager.white,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: SvgPicture.asset(
          ImageAssets.back,
          height: 20,
          width: 20,
          fit: BoxFit.scaleDown,
        ),
      ),
      elevation: 0.0,
    ),
  );
}
