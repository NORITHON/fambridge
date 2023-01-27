import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/font_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String point = "326";

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: ColorManager.grey,
      fontFamily: "GmarketSans",
      fontWeight: FontWeightManager.regular,
      fontSize: FontSize.s16,
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                _HomeTop(textStyle: textStyle),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 8),
                  child: Text(
                    "'우리'나무",
                    style: textStyle,
                  ),
                ),
                Text(
                  "${point}p",
                  style: textStyle.copyWith(
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSize.s20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeTop extends StatelessWidget {
  const _HomeTop({
    Key? key,
    required this.textStyle,
  }) : super(key: key);

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorManager.white,
            boxShadow: [
              BoxShadow(
                color: ColorManager.grey.withOpacity(0.25),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: SvgPicture.asset(
            ImageAssets.fambridgeIcon,
            width: 40,
            height: 40,
          ),
        ),
        SizedBox(width: 15),
        Text(
          "Fambridge",
          style: textStyle,
        ),
        SizedBox(width: 50),
        Container(
          padding: const EdgeInsets.all(0.0),
          child: IconButton(
            iconSize: 40,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: SvgPicture.asset(
              ImageAssets.bookmark,
              width: 40,
              height: 40,
            ),
            onPressed: () {}, //do something,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(0.0),
          child: IconButton(
            iconSize: 40,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: SvgPicture.asset(
              ImageAssets.profile,
              width: 40,
              height: 40,
            ),
            onPressed: () {}, //do something,
          ),
        ),
      ],
    );
  }
}
