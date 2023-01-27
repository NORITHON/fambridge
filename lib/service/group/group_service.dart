import 'package:fambridge/model/question.dart';

import 'package:fambridge/model/group.dart';

import '../../model/group_question.dart';
import 'firebase_group_provider.dart';
import 'group_provider.dart';

class GroupService implements GroupProvider {
  final GroupProvider provider;
  const GroupService(this.provider);

  factory GroupService.firebase() => GroupService(FirebaseGroupProvider());

  @override
  Future<bool?> checkIfAnswerShouldBeOpen(
          {required String groupId, required String todayQuestionId}) =>
      provider.checkIfAnswerShouldBeOpen(
          groupId: groupId, todayQuestionId: todayQuestionId);

  @override
  void createGroupQuestion(
          {required String groupId, required Question question}) =>
      provider.createGroupQuestion(groupId: groupId, question: question);

  @override
  void createNewGroup(
          {required String groupName, required String creatorUserId}) =>
      provider.createNewGroup(
          creatorUserId: creatorUserId, groupName: groupName);

  @override
  Stream<Iterable<GroupQuestion>> getAllGroupQuestion(
          {required String groupId}) =>
      provider.getAllGroupQuestion(groupId: groupId);

  @override
  Future<Group?> getGroup({required String groupId}) =>
      provider.getGroup(groupId: groupId);

  @override
  Future<GroupQuestion> getTodayGroupQuestion(
          {required String groupId, required String todayQuestionId}) =>
      provider.getTodayGroupQuestion(
          groupId: groupId, todayQuestionId: todayQuestionId);

  @override
  Future<int> howManyPeopleAnswered(
          {required String groupId, required String todayQuestionId}) =>
      provider.howManyPeopleAnswered(
          groupId: groupId, todayQuestionId: todayQuestionId);

  @override
  Future<int> howManyPeopleInGroup({required String groupId}) =>
      provider.howManyPeopleInGroup(groupId: groupId);

  @override
  void submitAnswerForGroupQuestion({
    required String groupId,
    required String answerScript,
    required String todayQuestionId,
    required String userId,
  }) =>
      provider.submitAnswerForGroupQuestion(
        groupId: groupId,
        answerScript: answerScript,
        todayQuestionId: todayQuestionId,
        userId: userId,
      );
}
