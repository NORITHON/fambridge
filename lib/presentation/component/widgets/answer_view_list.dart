import 'package:fambridge/presentation/component/profile/profile_image.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class AnswerViewListBuilder extends StatelessWidget {
  const AnswerViewListBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: ((context, index) {
        return AnswerViewList();
      }),
      separatorBuilder: ((context, index) {
        return const Divider(
          height: 28,
          thickness: 1,
        );
      }),
      itemCount: 10,
    );
  }
}

class AnswerViewList extends StatelessWidget {
  const AnswerViewList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnswerViewListItem(),
      ],
    );
  }
}

class AnswerViewListItem extends StatelessWidget {
  const AnswerViewListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnswerViewUserProfileAndName(),
        const SizedBox(height: 5),
        Text(
          "믿음, 소망, 사랑 그 중에 제일은 사랑이라.믿음, 소망, 사랑 그 중에 제일은 사랑이라.",
          style: getRegularStyle(
            color: ColorManager.lightGrey,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

class AnswerViewUserProfileAndName extends StatelessWidget {
  const AnswerViewUserProfileAndName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ProfileImage(size: 30),
        const SizedBox(width: 10),
        Text(
          "user name", //?? "no name",
          style: getRegularStyle(
            color: ColorManager.darkGrey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
