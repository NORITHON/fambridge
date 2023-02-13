
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fambridge/app/constants/database_fieldname/firebase_collection_name.dart';
import 'package:fambridge/model/answer.dart';
import 'package:fambridge/model/group_question.dart';
import 'package:fambridge/model/question_res.dart';
import 'package:uuid/uuid.dart';

import '../../model/group.dart';
import 'group_exception.dart';
import 'group_provider.dart';
import 'group_state_provider.dart';

class FirebaseGroupProvider implements GroupProvider {
  final groupCollection =
      FirebaseFirestore.instance.collection(groupCollectionName);
  final questionResCollection =
      FirebaseFirestore.instance.collection(questionResCollectionName);
  CollectionReference<Map<String, dynamic>> getGroupQuestionCollectionRef(
          String groupId) =>
      findGroupReference(groupId).collection(groupQuestionCollectionName);

  DocumentReference<Map<String, dynamic>> findGroupReference(String groupId) =>
      groupCollection.doc(groupId);

  @override
  Future<QuestionRes> getQuestionFromRes({int questionOrder = 0}) async {
    final snapshot = await questionResCollection
        .where(QuestionResFirestoreFieldName.questionOrderFieldName,
            isEqualTo: questionOrder)
        .get();
    if (snapshot.docs.isEmpty) {
      throw CannotFindMatchingQuestionFromQuestionResException();
    }
    return QuestionRes.fromSnapshot(snapshot.docs.first);
  }

  @override
  Future<Group> createNewGroup({
    int treeXp = 0,
  }) async {
    final familyGroupId = GroupStateProvider()
        .newGroupInfo[GroupFirestoreFieldName.groupIdFieldName];
    final todayQuestion = await createTodayQuestion(
        familyGroupId: GroupStateProvider()
            .newGroupInfo[GroupFirestoreFieldName.groupIdFieldName],
        questionOrder: 0);
    await groupCollection.doc(familyGroupId).set({
      GroupFirestoreFieldName.familyGroupCodeFieldname: GroupStateProvider()
          .newGroupInfo[GroupFirestoreFieldName.familyGroupCodeFieldname],
      GroupFirestoreFieldName.familyGroupCreatedTimeFieldname:
          FieldValue.serverTimestamp(),
      GroupFirestoreFieldName.groupIdFieldName: familyGroupId,
      GroupFirestoreFieldName.groupNameFieldName: GroupStateProvider()
          .newGroupInfo[GroupFirestoreFieldName.groupNameFieldName],
      GroupFirestoreFieldName.treeXpFieldName: treeXp,
      GroupFirestoreFieldName.joinedUserIdsFieldName: GroupStateProvider()
          .newGroupInfo[GroupFirestoreFieldName.joinedUserIdsFieldName],
      GroupFirestoreFieldName.todayQuestionFieldName: todayQuestion.toMap(),
      GroupFirestoreFieldName.totalNumOfFamilyMemberFieldName:
          GroupStateProvider().newGroupInfo[
              GroupFirestoreFieldName.totalNumOfFamilyMemberFieldName],
    });
    return Group.fromFirestore(await groupCollection.doc(familyGroupId).get());
  }

  @override
  Future<GroupQuestion> createTodayQuestion({
    required String familyGroupId,
    required int questionOrder,
  }) async {
    final String groupQuestionId = const Uuid().v4();
    final QuestionRes questionRes =
        await getQuestionFromRes(questionOrder: questionOrder);
    final List<Answer> answers = [];
    final groupQuestionDocRef =
        getGroupQuestionCollectionRef(familyGroupId).doc(groupQuestionId);
    await groupQuestionDocRef.set({
      GroupQuestionFirestoreFieldName.questionFieldName: questionRes.toMap(),
      GroupQuestionFirestoreFieldName.groupQuestionIdFieldName: groupQuestionId,
      GroupQuestionFirestoreFieldName.answersFieldName: answers,
      GroupQuestionFirestoreFieldName.createdTimeFieldName:
          FieldValue.serverTimestamp(),
      GroupQuestionFirestoreFieldName.isVisibleFieldName: false,
      GroupQuestionFirestoreFieldName.visualizableTimeFieldName: null,
      GroupQuestionFirestoreFieldName.questionOrderFieldName:
          questionRes.questionOrder,
      GroupQuestionFirestoreFieldName.rewardTreeXpFieldName: questionRes.treeXp,
    });
    return GroupQuestion.fromFirestore(await groupQuestionDocRef.get());
  }

  @override
  Stream<Group> getGroup({required String groupId}) {
    return findGroupReference(groupId).snapshots().map(
          (docSnap) => Group.fromFirestore(docSnap),
        );
  }

  Future<Group> test({required String groupId}) async {
    return Group.fromFirestore(await FirebaseFirestore.instance.collection('group').doc(groupId).get());
  }

  @override
  Stream<Iterable<GroupQuestion>> getAllGroupQuestion(
      {required String groupId}) {
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    return groupQuestionCollection.snapshots().map(
        (event) => event.docs.map((doc) => GroupQuestion.fromFirestore(doc)));
  }

  @override
  Future<GroupQuestion> addTodayQuestionToGroupQuestion(
      {required String groupId, required GroupQuestion groupQuestion}) async {
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    Map<String, Object?> todayQuestion = groupQuestion.toMap();
    todayQuestion[GroupQuestionFirestoreFieldName.isVisibleFieldName] = true;
    todayQuestion[GroupQuestionFirestoreFieldName.visualizableTimeFieldName] =
        FieldValue.serverTimestamp();
    await groupQuestionCollection
        .doc(groupQuestion.groupQuestionId)
        .set(todayQuestion);
    return GroupQuestion.fromFirestore(
        await groupQuestionCollection.doc(groupQuestion.groupQuestionId).get());
  }

  @override
  Future<void> updateFamilyGroup({
    required String docId,
    String? groupName,
    GroupQuestion? todayQuestion,
    int? treeXp,
    int? totalNumOfFamilyMember,
    String? targetUserId,
    bool shouldAddUserId = true,
  }) async {
    final doc = await groupCollection.doc(docId).get();
    return await groupCollection.doc(docId).update({
      GroupFirestoreFieldName.totalNumOfFamilyMemberFieldName:
          totalNumOfFamilyMember ??
              doc[GroupFirestoreFieldName.todayQuestionFieldName],
      GroupFirestoreFieldName.groupNameFieldName:
          groupName ?? doc[GroupFirestoreFieldName.groupNameFieldName],
      GroupFirestoreFieldName.todayQuestionFieldName:
          todayQuestion ?? doc[GroupFirestoreFieldName.todayQuestionFieldName],
      GroupFirestoreFieldName.treeXpFieldName:
          treeXp ?? doc[GroupFirestoreFieldName.treeXpFieldName],
      GroupFirestoreFieldName.joinedUserIdsFieldName: targetUserId == null
          ? doc[GroupFirestoreFieldName.joinedUserIdsFieldName]
          : shouldAddUserId
              ? FieldValue.arrayUnion([targetUserId])
              : FieldValue.arrayRemove([targetUserId]),
    });
  }
}
