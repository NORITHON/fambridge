import 'package:fambridge/model/answer.dart';
import 'package:fambridge/presentation/component/profile/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/group.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class CommentBuilder extends StatelessWidget {
  const CommentBuilder({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  List<Answer> _getAnswers() {
    return group.todayQuestion.answers;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: ((context, index) {
        return Comment(
          answer: _getAnswers()[index],
        );
      }),
      separatorBuilder: ((context, index) {
        return const Divider(
          height: 2,
        );
      }),
      itemCount: _getAnswers().length,
    );
  }
}

class Comment extends StatelessWidget {
  const Comment({
    Key? key,
    required this.answer,
  }) : super(key: key);

  final Answer answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const ProfileImage(size: 30),
                const SizedBox(width: 10),
                Text(
                  answer.userName ?? "no name",
                  style: getRegularStyle(
                    color: ColorManager.darkGrey,
                    fontSize: 16,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 140)),
                const Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      child: ProfileImage(size: 25),
                    ),
                    Positioned(
                      right: 20,
                      child: ProfileImage(size: 25),
                    ),
                    Positioned(
                      right: 40,
                      child: ProfileImage(size: 25),
                    ),
                  ],
                ),
                // const CircleProfile(size: 25),
                // const CircleProfile(size: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SvgPicture.asset(
                    ImageAssets.newlikeOn,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 0),
              child: Text(answer.answerScript,
                  style: getRegularStyle(
                    color: ColorManager.lightGrey,
                    fontSize: 15,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
