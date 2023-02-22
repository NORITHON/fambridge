import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StoreCoupon extends StatelessWidget {
  const StoreCoupon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Container(
        //style
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //storeCoupon top
            const SizedBox(height: 8),
            const StoreCouponTop(),

            //separator
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 24,
                  width: 12,
                  decoration: BoxDecoration(
                    color: ColorManager.questionbackgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(100),
                      topRight: Radius.circular(100),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: 284,
                  color: ColorManager.downloadbackgroundColor,
                ),
                Container(
                  height: 24,
                  width: 12,
                  decoration: BoxDecoration(
                    color: ColorManager.questionbackgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      topLeft: Radius.circular(100),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),

            //CouponAndDownload
            const CouponAndDownload(),
            const SizedBox(height: 11),
          ],
        ),
      ),
    );
  }
}

class CouponAndDownload extends StatelessWidget {
  const CouponAndDownload({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 52,
            height: 20,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: ColorManager.point,
              ),
            ),
            child: Center(
              child: Text(
                "여가",
                style: getMediumStyle(
                  color: ColorManager.point,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            width: 88.53,
            height: 30,
            decoration: BoxDecoration(
              color: ColorManager.downloadbackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  ImageAssets.download,
                ),
                Text(
                  "다운로드",
                  style: getMediumStyle(
                    color: ColorManager.lightGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StoreCouponTop extends StatelessWidget {
  const StoreCouponTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 30),
        //coupon image
        const Image(
          width: 80,
          height: 80,
          image: AssetImage(ImageAssets.everland),
        ),
        const SizedBox(width: 42),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "에버랜드 5인 가족 할인권",
              style: getMediumStyle(
                color: ColorManager.darkGrey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "현장 할인 60%",
              style: getBoldStyle(
                color: ColorManager.darkGrey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "2023.03.20일까지",
              style: getMediumStyle(
                color: ColorManager.lightGrey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
