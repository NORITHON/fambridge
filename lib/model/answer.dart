import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/database_fieldname/firebase_fieldname.dart';

class Answer{
  final String userId;
  final String answerScript;

  Answer({
  required  this.userId,
  required  this.answerScript,
});

  factory Answer.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snap){
    final snapshot = snap.data();
    return Answer(
      userId: snapshot[answerUserIdFieldName],
      answerScript: snapshot[answerScriptFieldName],
    );
  }
}