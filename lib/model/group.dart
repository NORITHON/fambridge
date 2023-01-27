import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fambridge/model/question.dart';

import '../constants/database_fieldname/firebase_fieldname.dart';

class Group{
  final List<String> userIdsInGroup;
  final String groupId;
  final String groupName;

  Group({
    required this.userIdsInGroup,
    required this.groupId,
    required this.groupName,
  });

  factory Group.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return Group(
      groupId: snapshot[groupIdFieldName],
      groupName: snapshot[groupNameFieldName], 
      userIdsInGroup: [userIdsInGroupFieldName],
    );
  }
}