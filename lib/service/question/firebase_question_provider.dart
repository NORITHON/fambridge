import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fambridge/constants/database_fieldname/firebase_collection_name.dart';

import 'question_provider.dart';
class FirebaseQuestionProvider implements QuestionProvider {
  final questionCollection =
         FirebaseFirestore.instance.collection(questionCollectionName);
  
}
