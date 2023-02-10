// provide FirebaseAuth user

import '../../model/question_res.dart';

abstract class QuestionProvider {
  Future<QuestionRes> getNextQuestion({String? originalQuestionId});
}
