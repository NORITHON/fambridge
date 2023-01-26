// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:norithon/model/user_model.dart';

// class UserService {
//   final _db = FirebaseFirestore.instance;

//   Future<bool> createNewUser(User user) async {
//     try {
//       await _db.collection("users").doc(user.id).set({
//         "name": user.name,
//         "email": user.email,
//       });
//       return true;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   Future<User> getUser(String uid) async {
//     try {
//       DocumentSnapshot snapshot = await _db.collection("users").doc(uid).get();
//       return User.fromSnapshot(snapshot);
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//   }
// }
