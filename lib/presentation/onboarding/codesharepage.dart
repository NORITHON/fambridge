import 'package:fambridge/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

var idController; //family code

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
                style: getMediumStyle(
                  color: ColorManager.point,
                  fontSize: FontSize.s16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "우리",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "라는 이름 아래 모인 우리.",
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text('아빠'),
                      Text('엄마'),
                      Text('첫째'),
                      Text('뚤째'),
                      Text('셋째'),
                    ]),
              ),
              Row(
                children: [
                  const Text(
                    "가족 코드",
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    idController, //family code
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      color: ColorManager.black.withOpacity(0.7),
                      fontSize: FontSize.s18,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
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
                    "복사하기",
                    style: textStyle,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.white,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    return;
                  },
                  child: Text(
                    "공유하기",
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
