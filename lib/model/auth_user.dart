import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth show User;
import 'package:flutter/foundation.dart';

import '../app/constants/enums/family_role.dart';

@immutable
class AuthUser {
  final String? docId;
  final String id;
  final String? name;
  final FamilyRole? familyRole;
  final int? birthOrder;
  final Timestamp? registerTime;
  final String? groupId;
  final bool? isEmailVerified;

  const AuthUser({
    required this.id,
    this.isEmailVerified,
    this.name,
    this.familyRole,
    this.birthOrder,
    this.registerTime,
    this.groupId,
    this.docId,
  });

  // create authuser from firebase user
  factory AuthUser.fromFirebase(FirebaseAuth.User user) => AuthUser(
    id: user.uid,
    isEmailVerified: user.emailVerified,
  );

  factory AuthUser.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
        var snapshotData = snapshot.data() as Map<String, dynamic>;
    return AuthUser(
      docId: snapshot.id,
      id: snapshotData[AuthUserFirestoreFieldName.userIdFieldName], 
      name: snapshotData[AuthUserFirestoreFieldName.userNameFieldName], 
      familyRole: _castStringToFamiltyRole(snapshotData[AuthUserFirestoreFieldName.userFamilyRoleFieldName]), 
      registerTime: snapshotData[AuthUserFirestoreFieldName.userRegisterTimeFieldName] as Timestamp,
      birthOrder: snapshotData[AuthUserFirestoreFieldName.userBirthOrderFieldName],
      groupId: snapshotData[AuthUserFirestoreFieldName.userGroupIdFieldName],
    );
  }
  
  static FamilyRole? _castStringToFamiltyRole(String string){
    for(FamilyRole role in FamilyRole.values){
      if(role.name == string){
        return role;
      }
    }
    return null;
  }
}

class AuthUserFirestoreFieldName{
  static const String userIdFieldName = 'user-id';
  static const String userNameFieldName = 'name';
  static const String userFamilyRoleFieldName = 'family-role';
  static const String userBirthOrderFieldName = 'birth-order';
  static const String userRegisterTimeFieldName = 'register-time';
  static const String userGroupIdFieldName = 'group-id';
}