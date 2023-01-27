import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/database_fieldname/firebase_fieldname.dart';

class Group{
  final List<String> userIdsInGroup;
  final String groupId;
  final String groupName;
  final List<String> userIdsWhoHaveAnsweredQuestion;

  Group({
    required this.userIdsInGroup,
    required this.groupId,
    required this.groupName,
    required this.userIdsWhoHaveAnsweredQuestion,
  });

  factory Group.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return Group(
      groupId: snapshot[groupIdFieldName],
      groupName: snapshot[groupNameFieldName], 
      userIdsInGroup: [userIdsInGroupFieldName], 
      userIdsWhoHaveAnsweredQuestion: [userIdsWhoHaveAnsweredQuestionFieldName],
    );
  }
}