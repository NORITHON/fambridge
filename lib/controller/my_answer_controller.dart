import 'package:get/state_manager.dart';

class MyAnswerController extends GetxController {
  RxString userAnswerTextInput = "".obs;

  void setuserAnswerTextInput(String script) {
    userAnswerTextInput.value = script;
  }
}
