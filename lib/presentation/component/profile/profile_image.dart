import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileImage extends StatelessWidget {
  final double size;
  const ProfileImage({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.transparent,
      ),
      child: SvgPicture.asset(
        ImageAssets.profile2,
        height: size,
        width: size,
        allowDrawingOutsideViewBox: true,
      ),
    );
  }
}
