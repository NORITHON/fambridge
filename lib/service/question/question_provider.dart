// provide FirebaseAuth user

import '../../model/question.dart';

abstract class QuestionProvider {
  Future<Iterable<Question>> getAllQuestionInList();
  Future<Question> getNextQuestion({String? originalQuestionId});
}
