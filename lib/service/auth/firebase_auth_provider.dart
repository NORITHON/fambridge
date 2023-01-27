import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fambridge/constants/database_fieldname/firebase_collection_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../constants/database_fieldname/firebase_fieldname.dart';
import '../../constants/enums/family_role.dart';
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
      final DocumentSnapshot<Map<String, dynamic>> snap = await authCollection.doc(user.uid).get();
      if(!snap.exists){
        return AuthUser.fromFirebase(user);
      }else{
        return AuthUser.fromSnapshot(snap);
      }
    } else {
      return null;
    }
  }

  @override
  Future<void> addAuthToDatabase({
    required String name,
    required FamilyRole familyRole,
    required int birthOrder,
    String? groupId,
  }) async {
    final AuthUser? user = await currentUser;
    if(user != null){
      if(user.name == null){
        await authCollection.doc(user.id).set({
          userIdFieldName: user.id,
          userNameFieldName: name,
          userFamilyRoleFieldName: familyRole.toString(),
          userBirthOrderFieldName: birthOrder,
          userGroupIdFieldName: groupId,
          userRegisterTimeFieldName: FieldValue.serverTimestamp(),
        });
      }
    }
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
    return await firebase_auth.FirebaseAuth.instance.signInWithCredential(credential);
  }


  @override
  Future<AuthUser> logIn() async {
    try {
      final u = await signInWithGoogle();
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
  Stream<firebase_auth.User?> getAuthStateChanges() => FirebaseAuth.instance.authStateChanges();

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
