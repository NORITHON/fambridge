import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  late final String? title;
  late final String? content;
  late final bool? done;
  String? id;
  late final DocumentReference? reference;

  bool? getDone() {
    return done;
  }

  Todo({this.title, this.content, this.done = false});

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'content': this.content,
      'done': this.done,
    };
  }

  Todo.fromMap(Map<String, dynamic> map, {required this.reference})
      : title = map['title'],
        content = map['content'],
        done = map['done'],
        id = map['id'].toString();

  Todo.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => "Todo<$id:$title:$content>";
}
