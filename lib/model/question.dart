import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fambridge/constants/database_fieldname/firebase_fieldname.dart';

class Question {
  final String questionId;
  final String questionScript;
  final Timestamp questionCreatedTimeStamp;

  final QuestionCategory? category;

  Question({
    required this.questionId,
    required this.questionScript,
    required this.questionCreatedTimeStamp,
    this.category = QuestionCategory.notDecided,
  });

  factory Question.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Question(
      questionCreatedTimeStamp: snapshot[questionCreatedTimeStampFieldName],
      questionId: snapshot[questionIdFieldName],
      questionScript: snapshot[questionScriptFieldName],
      category: snapshot[questionCategoryFieldName],
    );
  }

  Map<String, dynamic> toJson() => {
        questionCreatedTimeStampFieldName: questionCreatedTimeStamp,
        questionIdFieldName: questionId,
        questionScriptFieldName: questionScript,
        questionCategoryFieldName: category,
      };
}

enum QuestionCategory { notDecided }
