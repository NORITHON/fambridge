import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/database_fieldname/firebase_fieldname.dart';

class GroupQuestion{
  final Map<String, String> userIdsWhoHaveAnswered;
  final String groupQuestionId;
  final String questionScript;

  GroupQuestion({    
    required this.userIdsWhoHaveAnswered,
    required this.groupQuestionId,
    required this.questionScript,
  });

  factory GroupQuestion.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return GroupQuestion(
      userIdsWhoHaveAnswered: snapshot[userIdsWhoHaveAnsweredFieldName] as Map<String, String>,
      groupQuestionId: snapshot[groupQuestionIdFieldName], 
      questionScript: snapshot[groupQuestionScriptFieldName],
    );
  }
}