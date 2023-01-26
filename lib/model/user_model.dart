import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late final String? id;
  late final String? name;
  late final String? email;
  late final String? password;

  User({this.id, this.name, this.email, this.password});

  User.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.id;
    name = snapshot["name"];
    email = snapshot["email"];
  }
}
