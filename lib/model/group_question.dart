import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/database_fieldname/firebase_fieldname.dart';

class GroupQuestion{
  final Map<String, String> userIdsWhoHaveAnswered;
  final String groupQuestionId;
  final String originalQuestionId;
  final String questionScript;
  final bool isAnswerVisible;
  final int answerCount;

  GroupQuestion({    
    required this.userIdsWhoHaveAnswered,
    required this.groupQuestionId,
    required this.questionScript,
    required this.isAnswerVisible,
    required this.answerCount,
    required this.originalQuestionId,
  });

  factory GroupQuestion.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return GroupQuestion(
      userIdsWhoHaveAnswered: Map<String, String>.from(snapshot[userIdsWhoHaveAnsweredFieldName]),
      groupQuestionId: snapshot[groupQuestionIdFieldName], 
      questionScript: snapshot[groupQuestionScriptFieldName],
      isAnswerVisible: snapshot[isAnswerVisibleFieldName] ?? false,
      answerCount: snapshot[answerCountFieldName] ?? 0,
      originalQuestionId: snapshot[originalQuestionIdFieldName],
    );
  }
}