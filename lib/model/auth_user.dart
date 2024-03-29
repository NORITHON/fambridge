import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth show User;
import 'package:flutter/foundation.dart';

import '../app/constants/enums/family_role.dart';

@immutable
class AuthUser {
  final String? docId;
  final String id;
  final String? name;
  final String? familyRole;
  final int? birthOrder;
  final Timestamp? registerTime;
  final String? groupId;
  final bool? isEmailVerified;
  final Timestamp? lastLoginTime;

  const AuthUser({
    required this.id,
    this.isEmailVerified,
    this.name,
    this.familyRole,
    this.birthOrder,
    this.registerTime,
    this.groupId,
    this.docId,
    this.lastLoginTime,
  });

  // create authuser from firebase user
  factory AuthUser.fromFirebase(firebase_auth.User user) => AuthUser(
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
      familyRole: snapshotData[AuthUserFirestoreFieldName.userFamilyRoleFieldName],
      registerTime:
          snapshotData[AuthUserFirestoreFieldName.userRegisterTimeFieldName]
              as Timestamp?,
      birthOrder:
          snapshotData[AuthUserFirestoreFieldName.userBirthOrderFieldName],
      groupId: snapshotData[AuthUserFirestoreFieldName.userGroupIdFieldName],
      lastLoginTime:
          snapshotData[AuthUserFirestoreFieldName.lastLoginTimeFieldName]
              as Timestamp?,
    );
  }

  static FamilyRole? _castStringToFamiltyRole(String string) {
    for (FamilyRole role in FamilyRole.values) {
      if (role.name == string) {
        return role;
      }
    }
    return null;
  }
}

class AuthUserFirestoreFieldName {
  static const String userIdFieldName = 'user-id';
  static const String userNameFieldName = 'name';
  static const String userFamilyRoleFieldName = 'family-role';
  static const String userBirthOrderFieldName = 'birth-order';
  static const String userRegisterTimeFieldName = 'register-time';
  static const String userGroupIdFieldName = 'group-id';
  static const String lastLoginTimeFieldName = 'last-login-time';
}
