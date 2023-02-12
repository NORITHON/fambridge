import 'package:fambridge/model/answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/group.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';


class CommentBuilder extends StatelessWidget {
  const CommentBuilder({
    Key? key, required this.group,
  }) : super(key: key);

  final Group group;

  List<Answer> _getAnswers(){
    return group.todayQuestion.answers;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: ((context, index) {
        return Comment(answer: _getAnswers()[index],);
      }),
      separatorBuilder: ((context, index) {
        return const Divider(height: 2,);
      }),
      itemCount: _getAnswers().length,
    );
  }
}

class Comment extends StatelessWidget {
  const Comment({
    Key? key, required this.answer,
  }) : super(key: key);

  final Answer answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const CircleProfile(size: 25),
            const SizedBox(width: 10),
            Text(
              answer.userName ?? "no name",
              style: getMediumStyle(
                color: ColorManager.lightGrey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 0),
          child: Text(answer.answerScript,
              style: getMediumStyle(
                color: ColorManager.lightGrey,
                fontSize: 16,
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const CircleProfile(size: 30),
            const CircleProfile(size: 30),
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
  final double size;
  const CircleProfile({
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