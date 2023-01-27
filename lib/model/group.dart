import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fambridge/model/question.dart';

import '../constants/database_fieldname/firebase_fieldname.dart';

class Group{
  final List<String> userIdsInGroup;
  final String groupId;
  final String groupName;
  final int userCount;
  final String todayGroupQuestionId;

  Group({
    required this.userIdsInGroup,
    required this.groupId,
    required this.groupName,
    required this.userCount, 
    required this.todayGroupQuestionId,
  });

  factory Group.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return Group(
      groupId: snapshot[groupIdFieldName],
      groupName: snapshot[groupNameFieldName], 
      userIdsInGroup: snapshot[userIdsInGroupFieldName].cast<String>(),
      userCount: snapshot[userCountFieldName] ?? 0,
      todayGroupQuestionId: snapshot[todayGroupQuestionIdFieldName],
    );
  }
}