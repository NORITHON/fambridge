import 'package:fambridge/service/group/group_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AnswerViewModel extends GetxController {
  AnswerViewModel._internal(); // private named constructor
  static final AnswerViewModel instance =
      AnswerViewModel._internal(); // single instance -- singleton

  factory AnswerViewModel() => instance; // factory for the class instance

  final answerScript = "".obs;
  final isAnswerOpen = false.obs;
  final hasAnswered = false.obs;
  final treeXp = 0.0.obs;

  void setAnswerScript({String? newVal, bool listen = false}) {
    answerScript.value = newVal ?? answerScript.value;
    if(listen) update();
  }
  void setIsAnswerOpen({bool? newVal, bool listen = false}) {
    isAnswerOpen.value = newVal ?? false;
    if(listen) update();
  }
  void setHasAnswered({bool? newVal, bool listen = false}) {
    hasAnswered.value = newVal ?? false;
    if(listen) update();
  }
  void setTreeXp({double? newVal, bool listen = false}) {
    treeXp.value = newVal ?? treeXp.value;
    if(listen) update();
  }

  Future<void> init({required String groupId, String? userId, String? todayGroupQuestionId}) async {
    setTreeXp(newVal: await GroupService.firebase().getTreeXp(groupId: groupId), listen: false);
    setIsAnswerOpen(newVal: await GroupService.firebase().checkIfAnswerShouldBeOpen(groupId: groupId), listen: false);
    if(userId != null && todayGroupQuestionId != null){
      setHasAnswered(newVal: await GroupService.firebase().hasAnsweredTheQuestion(groupId: groupId, userId: userId, questionId: todayGroupQuestionId));
    } else{
      setHasAnswered(newVal: null); 
    }
  }
}