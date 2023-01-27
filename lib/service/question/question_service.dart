
import 'firebase_question_provider.dart';
import 'question_provider.dart';

class QuestionService implements QuestionProvider {
  final QuestionProvider provider;
  const QuestionService(this.provider);

  factory QuestionService.firebase() => QuestionService(FirebaseQuestionProvider());

}
