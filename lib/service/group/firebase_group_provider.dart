import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fambridge/constants/database_fieldname/firebase_collection_name.dart';
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

  void createNewGroup({
    required String groupName,
    required String creatorUserId,
  }){
    final String groupId = const Uuid().v4();
    groupCollection.doc(groupId).set({
      groupIdFieldName: groupId,
      groupNameFieldName: groupName,
      userIdsInGroupFieldName: [creatorUserId],
  });
  }

  Future<Group?> getGroup({required String groupId}) async {
    final docSnap = await findDocRef(groupId).get();
    if(!docSnap.exists){
      throw GroupNotFoundGroupException();
    }
    return Group.fromSnapshot(docSnap);
  }

  CollectionReference getGroupQuestionCollectionRef(String groupId) => findDocRef(groupId).collection(groupQuestionCollectionName);

  Stream<Iterable<GroupQuestion>> getAllGroupQuestion({required String groupId}){
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    return groupQuestionCollection.where(groupIdFieldName).snapshots().map(
        (event) => event.docs.map((doc) => GroupQuestion.fromSnapshot(doc)));
  }

  Future<GroupQuestion> getTodayGroupQuestion({required String groupId, required String todayQuestionId}) async {
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    return groupQuestionCollection.doc(todayQuestionId).get().then(((value) => GroupQuestion.fromSnapshot(value)));
  }

  void createGroupQuestion({required String groupId, required Question question}){
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    final String groupQuestionId = const Uuid().v4();
    groupQuestionCollection.doc(groupQuestionId).set({
      groupQuestionScriptFieldName: question.questionScript,
      groupQuestionIdFieldName: groupQuestionId,
      groupQuestionCreatedTimeFieldName: FieldValue.serverTimestamp(),
      userIdsWhoHaveAnsweredFieldName: {},
    });
  }

  void submitAnswerForGroupQuestion({
    required String groupId,
    required String answerScript,
    required String todayQuestionId,
    required String userId,
  }) {
    final groupQuestionCollection = getGroupQuestionCollectionRef(groupId);
    groupQuestionCollection.doc(todayQuestionId).collection('answers').add({userId: answerScript});
  }
}