import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fambridge/constants/database_fieldname/firebase_collection_name.dart';
import 'package:fambridge/constants/database_fieldname/firebase_fieldname.dart';

import '../../model/question.dart';
import 'question_provider.dart';
class FirebaseQuestionProvider implements QuestionProvider {
  final questionCollection =
         FirebaseFirestore.instance.collection(questionCollectionName);
  
  Future<Iterable<Question>> getAllQuestionInList() async {
    final snap = await questionCollection.orderBy(questionCreatedTimeStampFieldName, descending: false).get();
    return snap.docs.map((e) => Question.fromSnapshot(e));
  }
  Future<Question> getNextQuestion({String? originalQuestionId}) async {
    final questionList = await getAllQuestionInList();
    if(originalQuestionId == null){
      return questionList.first;
    } else{
      bool returnNextQuestion=false;
      for(final question in questionList){
        if(returnNextQuestion) return question;
        if(originalQuestionId == question.questionId){
          returnNextQuestion = true;
        }
      }
      return questionList.first;
    }
  }
}
