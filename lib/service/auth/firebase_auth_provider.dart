import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fambridge/service/crud/database_fieldname/firebase_collection_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../app/constants/enums/family_role.dart';
import '../../firebase_options.dart';

import 'auth_exceptions.dart';
import 'auth_provider.dart';
import '../../model/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FirebaseAuthProvider implements AuthProvider {
  final authCollection =
      FirebaseFirestore.instance.collection(userCollectionName);
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await firebase_auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = await currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<AuthUser?> get currentUser async {
    final user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      final QueryDocumentSnapshot<Map<String, dynamic>>? snap =
          await maybeGetUserFromFirestore(userId: user.uid);
      if (snap != null) {
        return AuthUser.fromSnapshot(snap);
      } else {
        return AuthUser.fromFirebase(user);
      }
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<QueryDocumentSnapshot<Map<String, dynamic>>?>
      maybeGetUserFromFirestore({required String userId}) async {
    final auth = await authCollection
        .where(AuthUserFirestoreFieldName.userIdFieldName, isEqualTo: userId)
        .get();
    if (auth.docs.isNotEmpty) {
      return auth.docs.first;
    }
    return null;
  }

  Future<bool> hasAuthbeenAddedInDatabase({required String userId}) async {
    return (await maybeGetUserFromFirestore(userId: userId)) != null;
  }

  @override
  Future<AuthUser?> addAuthToDatabase({
    required String name,
    required FamilyRole familyRole,
    required AuthUser? authUser,
    int? birthOrder,
    String? groupId,
  }) async {
    if (authUser == null) return null;
    if (await hasAuthbeenAddedInDatabase(userId: authUser.id)) return null;

    final docRef = await authCollection.add({
      AuthUserFirestoreFieldName.userIdFieldName: authUser.id,
      AuthUserFirestoreFieldName.userNameFieldName: name,
      AuthUserFirestoreFieldName.userFamilyRoleFieldName: familyRole.name,
      AuthUserFirestoreFieldName.userBirthOrderFieldName: birthOrder,
      AuthUserFirestoreFieldName.userGroupIdFieldName: groupId,
      AuthUserFirestoreFieldName.userRegisterTimeFieldName:
          FieldValue.serverTimestamp(),
    });
    return AuthUser.fromSnapshot(await docRef.get());
  }

  @override
  Future<AuthUser?> updateAuthUser({
    String? name,
    FamilyRole? familyRole,
    required AuthUser? authUser,
    int? birthOrder,
    bool shouldUpdateLastLoginTime = true,
  }) async {
    if (authUser == null) return null;

    final docSnapshot = await maybeGetUserFromFirestore(userId: authUser.id);
    if (docSnapshot == null) return null;
    final docSnapshotData = docSnapshot.data();

    await docSnapshot.reference.update({
      AuthUserFirestoreFieldName.userNameFieldName:
          name ?? docSnapshotData[AuthUserFirestoreFieldName.userNameFieldName],
      AuthUserFirestoreFieldName.userFamilyRoleFieldName: familyRole?.name ??
          docSnapshotData[AuthUserFirestoreFieldName.userFamilyRoleFieldName],
      AuthUserFirestoreFieldName.userBirthOrderFieldName: birthOrder ??
          docSnapshotData[AuthUserFirestoreFieldName.userBirthOrderFieldName],
      AuthUserFirestoreFieldName.lastLoginTimeFieldName:
          shouldUpdateLastLoginTime
              ? FieldValue.serverTimestamp()
              : docSnapshotData[
                  AuthUserFirestoreFieldName.lastLoginTimeFieldName],
    });
    return AuthUser.fromSnapshot(await docSnapshot.reference.get());
  }

  @override
  Future<firebase_auth.UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await firebase_auth.FirebaseAuth.instance
        .signInWithCredential(credential);
  }

  Future<void> deleteUserInfo() async {
    final user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user == null) {
      await logIn();
      deleteUserInfo();
    } else {
      await user.delete();
    }
  }

  @override
  Future<AuthUser> logIn() async {
    try {
      await signInWithGoogle().catchError((error) {
        log(error);
        throw UserNotLoggedInAuthException();
      });
      final AuthUser? user = await currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final AuthUser? user = await currentUser;
    if (user != null) {
      try {
        await firebase_auth.FirebaseAuth.instance.signOut();
      } on firebase_auth.FirebaseAuthException catch (_) {
        throw GenericAuthException();
      } catch (_) {
        throw GenericAuthException();
      }
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Stream<firebase_auth.User?> getAuthStateChanges() =>
      FirebaseAuth.instance.authStateChanges();

  @override
  Future<void> sendEmailVerification() async {
    final AuthUser? user = await currentUser;
    if (user != null) {
      if (!(user.isEmailVerified ?? false)) {
        await firebase_auth.FirebaseAuth.instance.currentUser
            ?.sendEmailVerification();
      }
    } else {
      throw UserNotLoggedInAuthException();
    }
  }
}
