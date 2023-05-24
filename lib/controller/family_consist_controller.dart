import 'package:get/state_manager.dart';

class FamilyConsistController extends GetxController {
  RxList<int> target = RxList<int>([]);
  RxInt targetMyself = 0.obs;

  List<int> getTraget() {
    List<int> result = [...target];
    result.sort();
    return result;
  }

  Map<String, int> familySet = {
    "할아버지": 1,
    "할머니": 2,
    "아빠": 3,
    "엄마": 4,
    "첫째": 5,
    "둘째": 6,
    "셋째": 7,
    "넷째": 8,
  };

  Map<int, String> familySetInvert = {
    1: "할아버지",
    2: "할머니",
    3: "아빠",
    4: "엄마",
    5: "첫째",
    6: "둘째",
    7: "셋째",
    8: "넷째",
  };
}
