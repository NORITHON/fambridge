import 'package:fambridge/presentation/resources/font_manager.dart';
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

class _codeshareState extends State<codeshareview> {
  var idController = "24983827"; //family code

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
              const SizedBox(height: 80),
              const Title(),
              const SizedBox(height: 10),
              const SubTitle(),
              const SizedBox(height: 40),
              FamilyList(),
              Row(
                children: [
                  const Text(
                    "가족 코드",
                    // style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    idController == null ? "" : idController, //family code
                    textAlign: TextAlign.center,
                    style: getBoldStyle(
                      color: ColorManager.darkGrey,
                      fontSize: 20,
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
                    style: getMediumStyle(
                      color: ColorManager.white,
                      fontSize: 16,
                    ),
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
                    style: getMediumStyle(
                      color: ColorManager.point,
                      fontSize: 16,
                    ),
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

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Fambridge.",
      textAlign: TextAlign.center,
      style: getMediumStyle(
        color: ColorManager.point,
        fontSize: FontSize.s16,
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "'우리'",
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
    );
  }
}

class FamilyList extends StatelessWidget {
  const FamilyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '아빠',
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 16,
            ),
          ),
          Text(
            '엄마',
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 16,
            ),
          ),
          Text(
            '첫째',
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 16,
            ),
          ),
          Text(
            '뚤째',
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 16,
            ),
          ),
          Text(
            '셋째',
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 16,
            ),
          ),
        ],
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
