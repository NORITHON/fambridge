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
          height: 4,
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnswerListItem(answer: answer),
      ],
    );
  }
}

class AnswerListItem extends StatelessWidget {
  const AnswerListItem({
    Key? key,
    required this.answer,
  }) : super(key: key);

  final Answer answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnswerUserProfileAndName(answer: answer),
            LikeUserListAndLikeButton(),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          answer.answerScript,
          style: getRegularStyle(
            color: ColorManager.lightGrey,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class LikeUserListAndLikeButton extends StatelessWidget {
  const LikeUserListAndLikeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: const [
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

            // children: 1234
            //   .toString()
            //   .split("")
            //   .map(
            //     (index) => Positioned(
            //       right: index == "0" ? null : 10,
            //       child: const ProfileImage(
            //         size: 25,
            //       ),
            //     ),
            //   )
            //   .toList(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset(
            ImageAssets.newlikeOn,
          ),
        ),
      ],
    );
  }
}

class AnswerUserProfileAndName extends StatelessWidget {
  const AnswerUserProfileAndName({
    Key? key,
    required this.answer,
  }) : super(key: key);

  final Answer answer;

  @override
  Widget build(BuildContext context) {
    return Row(
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
      ],
    );
  }
}
