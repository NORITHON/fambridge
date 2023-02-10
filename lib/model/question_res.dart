import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionRes {
  final String questionId;
  final String questionScript;
  final int questionOrder;
  final int treeXp;
  final QuestionCategory? category;

  QuestionRes({
    required this.questionOrder,
    required this.questionId,
    required this.questionScript,
    required this.treeXp,
    this.category,
  });

  factory QuestionRes.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if( snapshot.data() == null){
      log("snapshot data is null");
      throw Exception();
    }
    var snapshotData = snapshot.data()!;

    return QuestionRes.fromMap(snapshotData);
  }

  factory QuestionRes.fromMap(Map<String, dynamic> map) {
    return  QuestionRes(
      treeXp: map[QuestionResFirestoreFieldName.rewardTreeXpFieldName] ?? 20,
      questionOrder: map[QuestionResFirestoreFieldName.questionOrderFieldName],
      questionId: map[QuestionResFirestoreFieldName.questionIdFieldName],
      questionScript: map[QuestionResFirestoreFieldName.questionScriptFieldName],
      category: CastToQuestionCategory(map[QuestionResFirestoreFieldName.questionCategoryFieldName]).castToQuestionCategory(),
    );
  }

  Map<String, dynamic> toMap() => {
        QuestionResFirestoreFieldName.questionOrderFieldName: questionOrder,
        QuestionResFirestoreFieldName.questionIdFieldName: questionId,
        QuestionResFirestoreFieldName.questionScriptFieldName: questionScript,
        QuestionResFirestoreFieldName.questionCategoryFieldName: category.maybeToName(),
        QuestionResFirestoreFieldName.rewardTreeXpFieldName: treeXp,
      };
}

enum QuestionCategory { notDecided }

extension on QuestionCategory?{
  String maybeToName(){
    if(this == null){
      return QuestionCategory.notDecided.name;
    }
    return this!.name;
  }
}
extension CastToQuestionCategory on String?{
  QuestionCategory castToQuestionCategory(){
    if(this ==null){
      return QuestionCategory.notDecided;
    }
    for(var category in QuestionCategory.values){
      if(this == category.name) return category;
    }
    return QuestionCategory.notDecided;
  }
}


class QuestionResFirestoreFieldName{
  static const String questionOrderFieldName = 'question-order';
  static const String questionIdFieldName = 'question-id';
  static const String questionScriptFieldName = 'question-script';
  static const String questionCategoryFieldName = 'question-category';
  static const String rewardTreeXpFieldName = 'reward-tree-xp';
}