import 'package:cloud_firestore/cloud_firestore.dart';
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
    return await provider.createNewGroup();
  }

  Future<bool> isGroupExist({required String groupId}) async {
    return (await maybeGetGroupFromFirestore(groupId: groupId)) != null;
  }

  @override
  Future<QueryDocumentSnapshot<Map<String, dynamic>>?>
      maybeGetGroupFromFirestore({required String groupId}) async =>
          await provider.maybeGetGroupFromFirestore(groupId: groupId);

  @override
  Future<GroupQuestion> createTodayQuestion({
    required String familyGroupId,
    required int questionOrder,
  }) async {
    return await provider.createTodayQuestion(
        familyGroupId: familyGroupId, questionOrder: questionOrder);
  }

  @override
  Future<QuestionRes> getQuestionFromRes({int questionOrder = 0}) async =>
      await provider.getQuestionFromRes(questionOrder: questionOrder);

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
  }) async {
    group.todayQuestion.answers.add(answer);
    return await provider.updateFamilyGroup(
        docId: group.familyGroupId, todayQuestion: group.todayQuestion);
  }

  Future<void> setTreeXp({required Group group, required int setVal}) async {
    final int setTreeXpToFetch =
        group.treeXp + setVal * group.todayQuestion.rewardTreeXp;
    return await updateFamilyGroup(
        docId: group.familyGroupId, treeXp: setTreeXpToFetch);
  }

  int getTotalNumOfMemberInGroup({required Group group}) =>
      group.userIdsInGroup.length;

  int getNumOfAnswersForTodayQuestion({required Group group}) =>
      group.todayQuestion.answers.length;

  int requiredNumOfAnswersToVisualizeAnswers({required Group group}) =>
      (getTotalNumOfMemberInGroup(group: group) / 2).round() -
      getNumOfAnswersForTodayQuestion(group: group);

  bool checkIfAnswerCanBeVisualizable({required Group group}) {
    return requiredNumOfAnswersToVisualizeAnswers(group: group) <= 0;
  }

  bool hasUserAnsweredTodayQuestion(
      {required Group group, required String userId}) {
    final b = group.todayQuestion.answers
        .where((element) => element.userId == userId)
        .isNotEmpty;
    return b;
  }

  Future<bool> makeTodayQuestionAnswerVisualizable(
      {required Group group}) async {
    if (!checkIfAnswerCanBeVisualizable(group: group)) return false;
    await deleteGroupQuestion(group: group, questionIdToDelete: group.todayQuestion.groupQuestionId);
    final fetchedTodayQuestion = await addTodayQuestionToGroupQuestion(
        groupId: group.familyGroupId, groupQuestion: group.todayQuestion);
    await updateFamilyGroup(
        docId: group.familyGroupId, todayQuestion: fetchedTodayQuestion);
    return true;
  }

  @override
  Future<void> deleteGroupQuestion(
          {required Group group, required String questionIdToDelete}) async =>
      provider.deleteGroupQuestion(
          group: group, questionIdToDelete: questionIdToDelete);

  Future<void> addUserIntoGroup(
      {required String groupId, required String userId}) async {
    await updateFamilyGroup(
        docId: groupId, targetUserId: userId, shouldAddUserId: true);
  }

  @override
  Future<void> updateFamilyGroup(
          {required String docId,
          String? groupName,
          GroupQuestion? todayQuestion,
          int? treeXp,
          String? targetUserId,
          bool shouldAddUserId = true}) async =>
      await provider.updateFamilyGroup(
        docId: docId,
        groupName: groupName,
        shouldAddUserId: shouldAddUserId,
        targetUserId: targetUserId,
        todayQuestion: todayQuestion,
        treeXp: treeXp,
      );

  @override
  Future<GroupQuestion> addTodayQuestionToGroupQuestion(
          {required String groupId,
          required GroupQuestion groupQuestion}) async =>
      await provider.addTodayQuestionToGroupQuestion(
          groupId: groupId, groupQuestion: groupQuestion);
}
