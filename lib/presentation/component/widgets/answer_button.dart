import 'package:fambridge/app/app.dart';
import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/material.dart';
import '../../../model/group.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    Key? key, required this.onPressed, required this.group,
  }) : super(key: key);

  final VoidCallback onPressed; 
  final Group group;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  GroupService.firebase().hasUserAnsweredTodayQuestion(group: group, userId: MyApp.unsyncronizedAuthUser!.id) ? "대답보기" : "대답하기",
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