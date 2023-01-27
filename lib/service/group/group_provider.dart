// provide FirebaseAuth user

<<<<<<< HEAD
abstract class GroupProvider {}
=======
import '../../model/group.dart';
import '../../model/group_question.dart';
import '../../model/question.dart';

abstract class GroupProvider {
  Future<Group> createNewGroup({
    required String groupName,
    required String creatorUserId,
    required Question question,
  });
  Future<Group?> getGroup({required String groupId});
  Stream<Iterable<GroupQuestion>> getAllGroupQuestion(
      {required String groupId});
  Future<GroupQuestion> getTodayGroupQuestion(
      {required String groupId});
  String createGroupQuestion(
      {required String groupId, required Question question});
  void submitAnswerForGroupQuestion({
    required String groupId,
    required String answerScript,
    required String userId,
  });
  Future<int> howManyPeopleAnswered({
    required String groupId,
  });
  Future<int> howManyPeopleInGroup({required String groupId,});
  Future<bool?> checkIfAnswerShouldBeOpen({
    required String groupId,
  });
}
>>>>>>> main