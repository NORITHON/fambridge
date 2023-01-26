import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/database_fieldname/firebase_fieldname.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final int likes;
  final String postId;
  final DateTime datePublished;
  final String questionId;

  const Post(
      {required this.description,
      required this.uid,
      required this.username,
      required this.likes,
      required this.postId,
      required this.datePublished,
      required this.questionId,
      });

  factory Post.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {

    return Post(
      description: snapshot[postDescriptionFieldName],
      uid: snapshot[postUidFieldName],
      likes: snapshot[postLikesFieldName],
      postId: snapshot[postIdFieldName],
      datePublished: snapshot[postDatePublishedFieldName],
      username: snapshot[postUsernameFieldName],
      questionId: snapshot[postQuestionIdFieldName],
    );
  }

   Map<String, dynamic> toJson() => {
        postDescriptionFieldName: description,
        postUidFieldName: uid,
        postLikesFieldName: likes,
        postUsernameFieldName: username,
        postIdFieldName: postId,
        postDatePublishedFieldName: datePublished,
        postQuestionIdFieldName: questionId,
      };
}