import 'package:fambridge/app/app.dart';
import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/material.dart';
import '../../../model/group.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    Key? key,
    required this.onPressed,
    required this.group,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Group group;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 39),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.point.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      width: 350,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                GroupService.firebase().hasUserAnsweredTodayQuestion(
                        group: group, userId: MyApp.unsyncronizedAuthUser!.id)
                    ? "대답보기"
                    : "대답하기",
                style: getMediumStyle(
                  color: ColorManager.white,
                  fontSize: 16,
                ),
              ),
              const Icon(Icons.navigate_next),
            ],
          ),
        ),
      ),
    );
  }
}
