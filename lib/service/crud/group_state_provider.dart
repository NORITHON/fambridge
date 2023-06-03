import 'package:fambridge/model/group.dart';

class GroupStateProvider{
  GroupStateProvider._internal();
  static final GroupStateProvider instance =
      GroupStateProvider._internal(); // single instance -- singleton

  factory GroupStateProvider() => instance; // factory for the class instance

  final Map<String, dynamic> newGroupInfo = {
    GroupFirestoreFieldName.familyGroupCodeFieldname: null,
    GroupFirestoreFieldName.familyGroupCreatedTimeFieldname: null,
    GroupFirestoreFieldName.groupIdFieldName: null,
    GroupFirestoreFieldName.groupNameFieldName: null,
    GroupFirestoreFieldName.joinedUserIdsFieldName: null,
    GroupFirestoreFieldName.todayQuestionFieldName: null,
    GroupFirestoreFieldName.totalNumOfFamilyMemberFieldName: null,
    GroupFirestoreFieldName.treeXpFieldName: null,
    GroupFirestoreFieldName.myRoleFieldName: null,
  };
}
