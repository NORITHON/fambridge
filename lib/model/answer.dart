import 'package:cloud_firestore/cloud_firestore.dart';


class Answer{
  final String userId;
  final String answerScript;
  final Timestamp answerdTime;

  Answer({
  required  this.userId,
  required  this.answerScript,
  required this.answerdTime,
});

  factory Answer.fromMap(Map<String, dynamic> map){
    return Answer(
      userId: map[AnswerFirestoreFieldName.answerUserIdFieldName],
      answerScript: map[AnswerFirestoreFieldName.answerScriptFieldName],
      answerdTime: map[AnswerFirestoreFieldName.answerCreatedTimeFieldName],
    );
  }

  factory Answer.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    final snapshotData = snapshot.data();
    if(snapshotData == null){
      throw Exception();
    }
    return Answer.fromMap(snapshotData);
  }

  Map<String, dynamic> toMap(){
    return {
      AnswerFirestoreFieldName.answerUserIdFieldName: userId,
      AnswerFirestoreFieldName.answerScriptFieldName: answerScript,
      AnswerFirestoreFieldName.answerCreatedTimeFieldName: answerdTime,
    };
  }
}

class AnswerFirestoreFieldName{
  static const String answerUserIdFieldName = "user-id";
  static const String answerScriptFieldName = "answer-script";
  static const String answerCreatedTimeFieldName = 'created-time';
}