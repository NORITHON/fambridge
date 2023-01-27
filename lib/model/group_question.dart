import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/database_fieldname/firebase_fieldname.dart';

class GroupQuestion{
  final Map<String, String> userIdsWhoHaveAnswered;
  final String groupQuestionId;
  final String questionScript;
  final bool isAnswerVisible;
  final int answerCount;

  GroupQuestion({    
    required this.userIdsWhoHaveAnswered,
    required this.groupQuestionId,
    required this.questionScript,
    required this.isAnswerVisible,
    required this.answerCount,
  });

  factory GroupQuestion.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return GroupQuestion(
      userIdsWhoHaveAnswered: snapshot[userIdsWhoHaveAnsweredFieldName] as Map<String, String>,
      groupQuestionId: snapshot[groupQuestionIdFieldName], 
      questionScript: snapshot[groupQuestionScriptFieldName],
      isAnswerVisible: snapshot[groupQuestionScriptFieldName] ?? false,
      answerCount: snapshot[answerCountFieldName] ?? 0,
    );
  }
}