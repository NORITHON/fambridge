import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fambridge/app/constants/enums/family_role.dart';

import '../../app/app.dart';
import '../../app/constants/app_state_fieldname/auth_state.dart';
import 'firebase_auth_provider.dart';
import 'auth_provider.dart';
import '../../model/auth_user.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());
  factory AuthService.mockTesting(AuthProvider p) => AuthService(p);

  static AuthUser? nonSyncronizedUser;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(email: email, password: password);

  @override
  Future<AuthUser?> get currentUser => provider.currentUser;

  Future<void> initAuthStateForApp({required AuthUser authUser}) async {
    MyApp.unsyncronizedAuthUser = authUser;
    MyApp.appState[authStateFieldName]![hasGroupFieldName] =
        await hasAuthbeenAddedInDatabase(userId: authUser.id);
  }

  @override
  Future<AuthUser> logIn() async {
    final user = await provider.logIn();
    await initAuthStateForApp(authUser: user);
    return user;
  }

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser?> addAuthToDatabase({
    required String name,
    required String familyRole,
    required AuthUser? authUser,
    int? birthOrder,
    String? groupId,
  }) =>
      provider.addAuthToDatabase(
          name: name,
          familyRole: familyRole,
          birthOrder: birthOrder,
          groupId: groupId,
          authUser: authUser);

  @override
  Future<UserCredential> signInWithGoogle() => provider.signInWithGoogle();

  @override
  Stream<User?> getAuthStateChanges() => provider.getAuthStateChanges();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  Future<bool> hasAuthbeenAddedInDatabase({required String userId}) async {
    return (await maybeGetUserFromFirestore(userId: userId)) != null;
  }

  Future<AuthUser?> updateLastLoginTime({required AuthUser? authUser}) async {
    return await updateAuthUser(
        authUser: authUser, shouldUpdateLastLoginTime: true);
  }

  @override
  Future<QueryDocumentSnapshot<Map<String, dynamic>>?>
      maybeGetUserFromFirestore({required String userId}) =>
          provider.maybeGetUserFromFirestore(userId: userId);

  @override
  Future<AuthUser?> updateAuthUser(
      {required AuthUser? authUser,
      String? name,
      FamilyRole? familyRole,
      int? birthOrder,
      bool shouldUpdateLastLoginTime = true}) async {
    final fetchedAuthUser = await provider.updateAuthUser(
      authUser: authUser,
      name: name,
      familyRole: familyRole,
      birthOrder: birthOrder,
      shouldUpdateLastLoginTime: shouldUpdateLastLoginTime,
    );
    MyApp.unsyncronizedAuthUser = fetchedAuthUser;
    return fetchedAuthUser;
  }
}
