// provide FirebaseAuth user

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../app/constants/enums/family_role.dart';
import '../../model/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class AuthProvider {
  Future<AuthUser?> get currentUser;
  Future<void> initialize();
  Future<AuthUser> logIn();
  Future<AuthUser?> updateAuthUser({
    String? name,
    FamilyRole? familyRole,
    required AuthUser? authUser,
    int? birthOrder,
    bool shouldUpdateLastLoginTime = true,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<AuthUser?> addAuthToDatabase({
    required String name,
    required String familyRole,
    required AuthUser? authUser,
    int? birthOrder,
    String? groupId,
  });
  Future<firebase_auth.UserCredential> signInWithGoogle();
  Stream<User?> getAuthStateChanges();
  Future<void> sendEmailVerification();
  Future<QueryDocumentSnapshot<Map<String, dynamic>>?>
      maybeGetUserFromFirestore({required String userId});

  Future<AuthUser?> getUserInfo({required String userId});
  Future<List<AuthUser>> getUserInfos({required List<String> userIds});
}
