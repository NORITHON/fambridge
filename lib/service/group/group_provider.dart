// provide FirebaseAuth user

import '../../model/group.dart';
import '../../model/group_question.dart';
import '../../model/question.dart';

abstract class GroupProvider {
  void createNewGroup({
    required String groupName,
    required String creatorUserId,
  });
  Future<Group?> getGroup({required String groupId});
  Stream<Iterable<GroupQuestion>> getAllGroupQuestion(
      {required String groupId});
  Future<GroupQuestion> getTodayGroupQuestion(
      {required String groupId, required String todayQuestionId});
  void createGroupQuestion(
      {required String groupId, required Question question});
  void submitAnswerForGroupQuestion({
    required String groupId,
    required String answerScript,
    required String todayQuestionId,
    required String userId,
  });
  Future<int> howManyPeopleAnswered({
    required String groupId,
    required String todayQuestionId,
  });
  Future<int> howManyPeopleInGroup({required String groupId,});
  Future<bool?> checkIfAnswerShouldBeOpen({
    required String groupId,
    required String todayQuestionId,
  });
}
