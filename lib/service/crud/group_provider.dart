import '../../model/group.dart';
import '../../model/group_question.dart';
import '../../model/question_res.dart';

abstract class GroupProvider {
  Future<Group> createNewGroup({
    int treeXp = 0,
  });
  Future<GroupQuestion> createTodayQuestion({
    required String familyGroupId,
    required int questionOrder,
  });
  Future<QuestionRes> getQuestionFromRes({int questionOrder = 0});
  Stream<Group> getGroup({required String groupId});
  Stream<Iterable<GroupQuestion>> getAllGroupQuestion(
      {required String groupId});
  Future<GroupQuestion> addTodayQuestionToGroupQuestion(
      {required String groupId, required GroupQuestion groupQuestion});
  Future<void> updateFamilyGroup({
    required String docId,
    String? groupName,
    GroupQuestion? todayQuestion,
    int? treeXp,
    String? targetUserId,
    bool shouldAddUserId = true,
  });
  }
