import 'package:fambridge/model/group.dart';

import '../../model/answer.dart';
import '../../model/group_question.dart';
import '../../model/question_res.dart';
import 'firebase_provider.dart';
import 'group_provider.dart';

class GroupService implements GroupProvider {
  final GroupProvider provider;
  const GroupService(this.provider);

  factory GroupService.firebase() => GroupService(FirebaseGroupProvider());

  @override
  Future<Group> createNewGroup({
    int treeXp = 0,
  }) async {
    return provider.createNewGroup(
      
    );
  }

  @override
  Future<GroupQuestion> createTodayQuestion({
    required String familyGroupId,
    required int questionOrder,
  }) async {
    return provider.createTodayQuestion(
        familyGroupId: familyGroupId, questionOrder: questionOrder);
  }

  @override
  Future<QuestionRes> getQuestionFromRes({int questionOrder = 0}) =>
      provider.getQuestionFromRes(questionOrder: questionOrder);

  @override
  Stream<Iterable<GroupQuestion>> getAllGroupQuestion(
          {required String groupId}) =>
      provider.getAllGroupQuestion(groupId: groupId);

  @override
  Stream<Group> getGroup({required String groupId}) =>
      provider.getGroup(groupId: groupId);

  Future<void> submitAnswerForTodayQuestion({
    required Group group,
    required Answer answer,
  }) {
    group.todayQuestion.answers.add(answer);
    return provider.updateFamilyGroup(
        docId: group.familyGroupId, todayQuestion: group.todayQuestion);
  }

  Future<void> setTreeXp({required Group group, required int setVal }) {
    final int setTreeXpToFetch = group.treeXp + setVal*group.todayQuestion.rewardTreeXp;
    return updateFamilyGroup(docId: group.familyGroupId, treeXp: setTreeXpToFetch);
  }

  int getTotalNumOfMemberInGroup({required Group group}) =>
      group.userIdsInGroup.length;

  int getNumOfAnswersForTodayQuestion({required Group group}) =>
      group.todayQuestion.answers.length;

  bool checkIfAnswerCanBeVisualizable({required Group group}) {
    return (getTotalNumOfMemberInGroup(group: group) / 2).round() >
        getNumOfAnswersForTodayQuestion(group: group);
  }

  Future<bool> makeTodayQuestionAnswerVisualizable(
      {required Group group}) async {
    if (!checkIfAnswerCanBeVisualizable(group: group)) return false;
    final fetchedTodayQuestion = await addTodayQuestionToGroupQuestion(
        groupId: group.familyGroupId, groupQuestion: group.todayQuestion);
    await updateFamilyGroup(
        docId: group.familyGroupId, todayQuestion: fetchedTodayQuestion);
    return true;
  }

  @override
  Future<void> updateFamilyGroup(
          {required String docId,
          String? groupName,
          GroupQuestion? todayQuestion,
          int? treeXp,
          String? targetUserId,
          bool shouldAddUserId = true}) =>
      provider.updateFamilyGroup(
        docId: docId,
        groupName: groupName,
        shouldAddUserId: shouldAddUserId,
        targetUserId: targetUserId,
        todayQuestion: todayQuestion,
        treeXp: treeXp,
      );

  @override
  Future<GroupQuestion> addTodayQuestionToGroupQuestion(
          {required String groupId, required GroupQuestion groupQuestion}) =>
      provider.addTodayQuestionToGroupQuestion(
          groupId: groupId, groupQuestion: groupQuestion);
}
