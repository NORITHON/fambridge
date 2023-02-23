import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnswerCardComponent extends StatelessWidget {
  final int number;
  final String question;
  final int numberOfAnswerdFamily;

  const AnswerCardComponent({
    Key? key,
    required this.number,
    required this.question,
    required this.numberOfAnswerdFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(36, 36, 45, 26),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.darkGrey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 0), // changes position of shadow
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${number.toString().padLeft(2, '0')}. ",
            style: getBoldStyle(
              color: ColorManager.point,
              fontSize: 16,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                  style: getMediumStyle(
                    color: ColorManager.darkGrey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "$numberOfAnswerdFamily명 참여",
                  style: getMediumStyle(
                    color: ColorManager.lightGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: SvgPicture.asset(
              number % 2 == 0
                  ? ImageAssets.bookmark
                  : ImageAssets.bookmarkClick,
            ),
            onPressed: () {}, //do something,
          )
        ],
      ),
    );
  }
}
