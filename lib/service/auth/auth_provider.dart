// provide FirebaseAuth user

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/enums/family_role.dart';
import '../../model/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class AuthProvider {
  Future<AuthUser?> get currentUser;
  Future<void> initialize();
  Future<AuthUser> logIn();
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> addAuthToDatabase({
    required String name,
    required FamilyRole familyRole,
    required int birthOrder,
    String? groupId,
  });
  Future<firebase_auth.UserCredential> signInWithGoogle();
  Stream<User?> getAuthStateChanges();
  Future<void> sendEmailVerification();
}
