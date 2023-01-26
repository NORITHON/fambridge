// provide FirebaseAuth user

import 'package:flutter/cupertino.dart';
import '../../model/auth_user.dart';

abstract class AuthProvider {
  Future<AuthUser?> get currentUser;
  Future<void> initialize();
  Future<AuthUser> logIn();
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  String? userDisplayName();
  Future<void> logOut();
}
