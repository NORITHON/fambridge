import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth show User;
import 'package:flutter/foundation.dart';

import '../constants/enums/family_role.dart';
import '../constants/database_fieldname/firebase_fieldname.dart';

@immutable
class AuthUser {
  final String id;
  final String? name;
  final FamilyRole? familyRole;
  final int? birthOrder;
  final Timestamp? registerTime;
  final String? groupId;

  const AuthUser({
    required this.id,
    this.name,
    this.familyRole,
    this.birthOrder,
    this.registerTime,
    this.groupId,
  });

  // create authuser from firebase user
  factory AuthUser.fromFirebase(FirebaseAuth.User user) => AuthUser(
    id: user.uid,
  );

  factory AuthUser.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
        var snapshot = snap.data() as Map<String, dynamic>;
    return AuthUser(
      id: snapshot[userIdFieldName], 
      name: snapshot[userNameFieldName], 
      familyRole: snapshot[userFamilyRoleFieldName], 
      registerTime: snapshot[userRegisterTimeFieldName],
      birthOrder: snapshot[userBirthOrderFieldName],
      groupId: snapshot[userGroupIdFieldName],
    );
  }
  

  
}
