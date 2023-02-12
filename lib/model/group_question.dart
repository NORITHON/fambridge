import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fambridge/model/answer.dart';
import 'question_res.dart';

class GroupQuestion {
  final QuestionRes question;
  final String groupQuestionId;
  final Timestamp createdTime;
  final bool isVisible;
  final Timestamp? visualizableTime;
  final int questionOrder;
  final int rewardTreeXp;
  final List<Answer> answers;

  GroupQuestion({
    required this.answers,
    required this.question,
    required this.groupQuestionId,
    required this.createdTime,
    required this.isVisible,
    this.visualizableTime,
    required this.questionOrder,
    required this.rewardTreeXp,
  });

  factory GroupQuestion.fromMap(Map<String, dynamic> map) {
    return GroupQuestion(
      answers: List.from(map[GroupQuestionFirestoreFieldName.answersFieldName])
          .map((answer) => Answer.fromMap(answer))
          .toList(),
      question: QuestionRes.fromMap(
          map[GroupQuestionFirestoreFieldName.questionFieldName]),
      groupQuestionId:
          map[GroupQuestionFirestoreFieldName.groupQuestionIdFieldName],
      createdTime: map[GroupQuestionFirestoreFieldName.createdTimeFieldName],
      isVisible: map[GroupQuestionFirestoreFieldName.isVisibleFieldName],
      questionOrder:
          map[GroupQuestionFirestoreFieldName.questionOrderFieldName],
      rewardTreeXp: map[GroupQuestionFirestoreFieldName.rewardTreeXpFieldName],
      visualizableTime:
          map[GroupQuestionFirestoreFieldName.visualizableTimeFieldName],
    );
  }
  
  factory GroupQuestion.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() == null) {
      log("snapshot data is null");
      throw Exception();
    }
    var snapshotData = snapshot.data()!;
    return GroupQuestion.fromMap(snapshotData);
  }

  Map<String, Object?> toMap() {
    return {
      GroupQuestionFirestoreFieldName.answersFieldName:
          answers.map((answer) => answer.toMap()).toList(),
      GroupQuestionFirestoreFieldName.questionFieldName: question.toMap(),
      GroupQuestionFirestoreFieldName.groupQuestionIdFieldName: groupQuestionId,
      GroupQuestionFirestoreFieldName.createdTimeFieldName: createdTime,
      GroupQuestionFirestoreFieldName.isVisibleFieldName: isVisible,
      GroupQuestionFirestoreFieldName.questionOrderFieldName: questionOrder,
      GroupQuestionFirestoreFieldName.rewardTreeXpFieldName: rewardTreeXp,
      GroupQuestionFirestoreFieldName.visualizableTimeFieldName:
          visualizableTime,
    };
  }
}

class GroupQuestionFirestoreFieldName {
  static const String questionFieldName = 'question';
  static const String groupQuestionIdFieldName = 'group-question-id';
  static const String createdTimeFieldName = 'created-time';
  static const String isVisibleFieldName = 'are-answers-visible';
  static const String visualizableTimeFieldName = 'answers-visualized-time';
  static const String questionOrderFieldName = 'question-order';
  static const String rewardTreeXpFieldName = 'reward-tree-xp';
  static const String answersFieldName = 'answers';
}
