import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class codeshareview extends StatefulWidget {
  const codeshareview({super.key});

  @override
  _codeshareState createState() => _codeshareState();
}

var textStyle = const TextStyle(
  fontFamily: 'GmarketSans',
  fontSize: 16,
);
var pointStyle = TextStyle(
  color: ColorManager.point,
  fontFamily: 'GmarketSans',
);

class _codeshareState extends State<codeshareview> {
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
              const SizedBox(height: 150),
              Text(
                "Fambridge.",
                textAlign: TextAlign.center,
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "우리라는 이름 아래 모인 우리.",
                textAlign: TextAlign.center,
                style: textStyle,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "모든 '우리'가 모여야",
                textAlign: TextAlign.center,
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "서비스가 시작됩니다.",
                textAlign: TextAlign.center,
                style: textStyle,
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.point,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    return;
                  },
                  child: Text(
                    "확인",
                    style: textStyle,
                  ),
                ),
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
