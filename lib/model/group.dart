import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../service/crud/group_exception.dart';
import 'group_question.dart';

class Group {
  final String groupJoinCode;
  final Timestamp createdTime;
  final String familyGroupId;
  final String groupName;
  final int treeXp;
  final int totalNumOfFamilyMember;
  final List<String> userIdsInGroup;
  final GroupQuestion todayQuestion;

  Group({
    required this.totalNumOfFamilyMember,
    required this.userIdsInGroup,
    required this.familyGroupId,
    required this.groupName,
    required this.todayQuestion,
    required this.treeXp,
    required this.groupJoinCode,
    required this.createdTime,
  });

  factory Group.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() == null) {
      log("doc snapshot data is null");
      throw GroupNotFoundGroupException;
    }
    var snapshotData = snapshot.data()!;
    return Group(
      familyGroupId: snapshotData[GroupFirestoreFieldName.groupIdFieldName],
      groupName: snapshotData[GroupFirestoreFieldName.groupNameFieldName],
      userIdsInGroup:
          snapshotData[GroupFirestoreFieldName.joinedUserIdsFieldName]
              .cast<String>(),
      todayQuestion: GroupQuestion.fromMap(
          snapshotData[GroupFirestoreFieldName.todayQuestionFieldName]),
      treeXp: snapshotData[GroupFirestoreFieldName.treeXpFieldName],
      createdTime:
          snapshotData[GroupFirestoreFieldName.familyGroupCreatedTimeFieldname]
              as Timestamp,
      groupJoinCode:
          snapshotData[GroupFirestoreFieldName.familyGroupCodeFieldname],
      totalNumOfFamilyMember:
          snapshotData[GroupFirestoreFieldName.totalNumOfFamilyMemberFieldName],
    );
  }
}

class GroupFirestoreFieldName {
  static const String familyGroupCodeFieldname = 'family-group-code';
  static const String familyGroupCreatedTimeFieldname = 'created-time';
  static const String groupIdFieldName = 'family-group-id';
  static const String groupNameFieldName = 'group-name';
  static const String treeXpFieldName = 'tree-xp';
  static const String joinedUserIdsFieldName = 'joined-user-ids';
  static const String todayQuestionFieldName = 'today-question';
  static const String totalNumOfFamilyMemberFieldName =
      'total-num-of-family-member';
      static const String myRoleFieldName =
      'my-role-in-family';
}
