import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fambridge/constants/database_fieldname/firebase_collection_name.dart';
import 'package:fambridge/model/answer.dart';
import 'package:fambridge/model/group_question.dart';
import 'package:fambridge/model/question.dart';
import 'package:uuid/uuid.dart';

import '../../constants/database_fieldname/firebase_fieldname.dart';
import '../../model/group.dart';
import 'group_exception.dart';
import 'group_provider.dart';

class FirebaseGroupProvider implements GroupProvider {
  final groupCollection =
      FirebaseFirestore.instance.collection(groupCollectionName);

  DocumentReference findDocRef(String docId) => groupCollection.doc(docId);

  @override
  Future<Group> createNewGroup({
    required String groupName,
    required String creatorUserId,
    required Question question,
  }) async {
    final String groupId = const Uuid().v4();
    final todayQuestionId = createGroupQuestion(groupId: groupId, question: question);
    await groupCollection.doc(groupId).set({
      groupIdFieldName: groupId,
      groupNameFieldName: groupName,
      userIdsInGroupFieldName: [creatorUserId],
      userCountFieldName: 1,
      todayGroupQuestionIdFieldName: todayQuestionId,
    });
    return Group.fromSnapshot(await groupCollection.doc(groupId).get());
  }

  @override
  Future<Group?> getGroup({required String groupId}) async {
    final docSnap = await findDocRef(groupId).get();
    if (!docSnap.exists) {
      throw GroupNotFoundGroupException();
    }
    return Group.fromSnapshot(docSnap);
  }

  CollectionReference getGroupQuestionCollectionRef(String groupId) =>
      findDocRef(groupId).collection(groupQuestionCollectionName);

  @override
  Stream<Iterable<GroupQuestion>> getAllGroupQuestion(
      {required String groupId}) {
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    return groupQuestionCollection.where(groupIdFieldName).snapshots().map(
        (event) => event.docs.map((doc) => GroupQuestion.fromSnapshot(doc)));
  }

  @override
  Future<GroupQuestion> getTodayGroupQuestion(
      {required String groupId}) async {
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    final todayQuestionId = await _getTodayGroupQuestionId(groupId);
    final docRef = await groupQuestionCollection
        .doc(todayQuestionId)
        .get();
    return GroupQuestion.fromSnapshot(docRef);  
  }

  Future<String> _getTodayGroupQuestionId(groupId) async =>  (await getGroup(groupId: groupId))!.todayGroupQuestionId;

  @override
  String createGroupQuestion(
      {required String groupId, required Question question}) {
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    final String groupQuestionId = const Uuid().v4();
    groupQuestionCollection.doc(groupQuestionId).set({
      groupQuestionScriptFieldName: question.questionScript,
      groupQuestionIdFieldName: groupQuestionId,
      groupQuestionCreatedTimeFieldName: FieldValue.serverTimestamp(),
      userIdsWhoHaveAnsweredFieldName: {},
      originalQuestionIdFieldName: question.questionId,
      isAnswerVisibleFieldName: false,
      answerCountFieldName: 0,
      treeXpFieldName: 0,
    });
    return groupQuestionId;
  }

  Future<void> _incrementAnswerCount(String groupId, String todayQuestionId) async {
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    final answerCount = await howManyPeopleAnswered(groupId: groupId);
    groupQuestionCollection.doc(todayQuestionId).update({
      answerCountFieldName: answerCount+1
    });
  }

  Future<double> getTreeXp({required String groupId}) async {
    final docSnap = await groupCollection.doc(groupId).get();
    if(!docSnap.exists) throw GroupNotFoundGroupException();
    return docSnap.data()?[treeXpFieldName] ?? 0;
  }

  Future<void> _incrementTreeXp({required String groupId, double xp = 10}) async {
    final currXp = await getTreeXp(groupId: groupId);
    groupCollection.doc(groupId).update({
      treeXpFieldName: currXp+xp
    });
  }

  @override
  Future<void> submitAnswerForGroupQuestion({
    required String groupId,
    required String answerScript,
    required String userId,
  }) async {
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    final todayQuestionId = await _getTodayGroupQuestionId(groupId);
    _incrementAnswerCount(groupId, todayQuestionId);
    _incrementTreeXp(groupId: groupId);
    groupQuestionCollection
        .doc(todayQuestionId)
        .collection(groupQuestionAnswerCollectionName)
        .add({
      answerUserIdFieldName: userId,
      answerScriptFieldName: answerScript,
    });
  }

  @override
  Future<int> howManyPeopleAnswered({
    required String groupId,
  }) async {
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    final todayQuestionId = await _getTodayGroupQuestionId(groupId);
    final docSnap = await groupQuestionCollection.doc(todayQuestionId).get()
        as DocumentSnapshot<Map<String, dynamic>>;
    if (!docSnap.exists) throw GroupQuestionNotFoundGroupException();
    return docSnap.data()?[answerCountFieldName];
  }

  @override
  Future<int> howManyPeopleInGroup({required String groupId,}) async {
    final docSnap = await groupCollection.doc(groupId).get();
    if(!docSnap.exists) throw GroupNotFoundGroupException();
    return docSnap.data()?[userCountFieldName] ?? 1;
  }

  bool logicForOpeningAnswer({required int answerCount, required int userCount,}){
    return answerCount*1.0 / userCount*1.0 > 0.5;
  }

  @override
  Future<bool?> checkIfAnswerShouldBeOpen({
    required String groupId,
  }) async {
    try{
      final answerCount = await howManyPeopleAnswered(groupId: groupId);
      final userCount = await howManyPeopleInGroup(groupId: groupId);
      return logicForOpeningAnswer(answerCount: answerCount, userCount: userCount);
    } on GroupQuestionNotFoundGroupException catch(_){
      return false;
    } on GroupNotFoundGroupException catch(_){
      return false;
    }

  }

  @override
  Future<bool> hasAnsweredTheQuestion({required String groupId, required String userId, required String questionId}) async {
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    final groupQuestionAnswerCollection = groupQuestionCollection.doc(questionId).collection(groupQuestionAnswerCollectionName);
    final listAnswers = await groupQuestionAnswerCollection.get().then((value) => value.docs.map((e) => Answer.fromSnapshot(e),));
    for(final answer in listAnswers){
      if(answer.userId == userId) return true;
    }
    return false;
  }
}
