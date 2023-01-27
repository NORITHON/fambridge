import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class CommentBuilder extends StatelessWidget {
  const CommentBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: ((context, index) {
        return const Comment();
      }),
      separatorBuilder: ((context, index) {
        return const Divider(height: 2,);
      }),
      itemCount: 10,
    );
  }
}

class Comment extends StatelessWidget {
  const Comment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            CircleProfile(size: 25),
            const SizedBox(width: 10),
            Text(
              "첫째",
              style: getMediumStyle(
                color: ColorManager.lightGrey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 0),
          child: Text("서로에게 무관심하나 마음만은 서로를 향해있는 가족",
              style: getMediumStyle(
                color: ColorManager.lightGrey,
                fontSize: 16,
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleProfile(size: 30),
            CircleProfile(size: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SvgPicture.asset(ImageAssets.likeOn),
            ),
          ],
        ),
      ],
    );
  }
}

class CircleProfile extends StatelessWidget {
  double size;
  CircleProfile({
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
        ImageAssets.onboardingLogo1,
        height: size,
        width: size,
        allowDrawingOutsideViewBox: true,
      ),
    );
  }
}