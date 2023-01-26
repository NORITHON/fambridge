import 'package:firebase_auth/firebase_auth.dart';

import 'package:fambridge/constants/enums/family_role.dart';

import 'firebase_auth_provider.dart';
import 'auth_provider.dart';
import '../../model/auth_user.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());
  factory AuthService.mockTesting(AuthProvider p) => AuthService(p);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(email: email, password: password);

  @override
  Future<AuthUser?> get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn() =>
      provider.logIn();

  @override
  Future<void> logOut() => provider.logOut();

  
  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<void> addAuthToDatabase({required String name, required FamilyRole familyRole, required int birthOrder, String? groupId}) =>
    provider.addAuthToDatabase(name: name, familyRole: familyRole, birthOrder: birthOrder);

  @override
  Future<UserCredential> signInWithGoogle() => provider.signInWithGoogle();
}
