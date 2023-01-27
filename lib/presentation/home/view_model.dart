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
}