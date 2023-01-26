import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/todo_model.dart';

class TodoService {
  final _db = FirebaseFirestore.instance;
  final _collection = "todo";

  //read
  Stream<List<Todo>> getStream() {
    Stream<QuerySnapshot> snapshots = _db.collection(_collection).snapshots();

    Stream<List<Todo>> result = snapshots.map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => Todo.fromSnapshot(doc),
          )
          .toList(),
    );
    return result;
  }

  Future<Todo> getByReference(DocumentReference reference) async {
    DocumentSnapshot result = await reference.get();
    return result.data() == null ? Todo() : Todo.fromSnapshot(result);
  }

//create
  Future<Todo> create(Todo newTodo) async {
    Map<String, dynamic> data = newTodo.toMap();

    //db에 todo 객체 생성 후 id 업데이트 + 객체 반환
    DocumentSnapshot result = await _db
        .collection(_collection)
        .add(data)
        .then((DocumentReference reference) {
      //id 업데이트
      reference.update({"id": reference.id});
      //객체 반환
      return reference.get();
    });

    Todo todo = Todo.fromSnapshot(result);
    return todo;
  }

//update
  Future<int> updateByReference(
      Todo newTodo, DocumentReference reference) async {
    Map<String, dynamic> data = newTodo.toMap();

    //void 반환
    await newTodo.reference!.update(data);

    //void이기 때문에 get하여 update 완료 확인하기
    Todo todo = await getByReference(newTodo.reference!);
    bool result =
        todo.title == newTodo.title && todo.content == newTodo.content;
    return result ? 1 : -1;
  }

  //delete
  Future<int> deleteByReference(DocumentReference reference) async {
    //void 반환
    await reference.delete();

    //void이기 때문에 get 하여 delete 완료 확인하기
    Todo todo = await getByReference(reference);
    return todo.id == null ? 1 : -1;
  }
}
