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
  final bool? isEmailVerified;

  const AuthUser({
    required this.id,
    this.isEmailVerified,
    this.name,
    this.familyRole,
    this.birthOrder,
    this.registerTime,
    this.groupId,
  });

  // create authuser from firebase user
  factory AuthUser.fromFirebase(FirebaseAuth.User user) => AuthUser(
    id: user.uid,
    isEmailVerified: user.emailVerified,
  );

  factory AuthUser.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
        var snapshot = snap.data() as Map<String, dynamic>;
    return AuthUser(
      id: snapshot[userIdFieldName], 
      name: snapshot[userNameFieldName], 
      familyRole: _castStringToFamiltyRole(snapshot[userFamilyRoleFieldName]), 
      registerTime: snapshot[userRegisterTimeFieldName] as Timestamp,
      birthOrder: snapshot[userBirthOrderFieldName],
      groupId: snapshot[userGroupIdFieldName],
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
