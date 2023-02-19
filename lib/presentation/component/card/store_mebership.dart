import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StoreMembership extends StatelessWidget {
  const StoreMembership({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 3),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(37.5, 26, 37.5, 26),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FamilyProfileAndName(),
                Container(
                  width: 101,
                  height: 28,
                  decoration: BoxDecoration(
                      color: ColorManager.point,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "프리미엄 구독권",
                      style: getMediumStyle(
                        color: ColorManager.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                MembershipPoint(),
                adversityAndDiscount(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyProfileAndName extends StatelessWidget {
  const FamilyProfileAndName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Image(
          width: 47.93,
          height: 47.93,
          image: AssetImage(
            ImageAssets.familyProfile,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          "홍시네 가족",
          style: getMediumStyle(
            color: ColorManager.darkGrey,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class adversityAndDiscount extends StatelessWidget {
  const adversityAndDiscount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(12, 4, 10, 4),
          decoration: BoxDecoration(
              color: ColorManager.chipbackgroundColor,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              SvgPicture.asset(
                ImageAssets.advertise,
                width: 10.5,
                height: 7,
              ),
              Text(
                "  광고 제거",
                style: getMediumStyle(
                  color: ColorManager.lightGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 4, 10, 4),
          decoration: BoxDecoration(
              color: ColorManager.chipbackgroundColor,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              SvgPicture.asset(
                ImageAssets.money,
                width: 6.79,
                height: 12,
              ),
              Text(
                " 월 50,000 할인",
                style: getMediumStyle(
                  color: ColorManager.lightGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MembershipPoint extends StatelessWidget {
  const MembershipPoint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "포인트",
              style: getMediumStyle(
                color: ColorManager.lightGrey,
                fontSize: 15,
              ),
            ),
            SizedBox(
              width: 3,
            ),
            SvgPicture.asset(
              ImageAssets.information,
              width: 15,
              height: 15,
            ),
          ],
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          "365pt",
          style: getBoldStyle(
            color: ColorManager.point,
            fontSize: AppSize.s20,
          ),
        ),
      ],
    );
  }
}
