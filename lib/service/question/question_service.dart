
import 'package:fambridge/model/question.dart';

import 'firebase_question_provider.dart';
import 'question_provider.dart';

class QuestionService implements QuestionProvider {
  final QuestionProvider provider;
  const QuestionService(this.provider);

  factory QuestionService.firebase() => QuestionService(FirebaseQuestionProvider());

  @override
  Future<Iterable<Question>> getAllQuestionInList() => provider.getAllQuestionInList();

  @override
  Future<Question> getNextQuestion({String? originalQuestionId}) => provider.getNextQuestion(originalQuestionId: originalQuestionId);

}
