import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/todo_model.dart';
import '../service/todo_service.dart';
import 'package:get/state_manager.dart';

class TodoController extends GetxController {
  TodoService _todoService = TodoService();

  @override
  void onInit() {
    super.onInit();
    //stream binding 하기 추가
  }

  //read
  Stream<List<Todo>> getStream() {
    return _todoService.getStream();
  }

  //create
  Future<int> create(Todo newTodo) async {
    Todo todo = await _todoService.create(newTodo);

    if (todo.reference != null) return 1;
    return -1;
  }

  //update
  Future<int> updateByReference(
      Todo newTodo, DocumentReference reference) async {
    int result = await _todoService.updateByReference(newTodo, reference);

    return result;
  }

  //delete
  Future<int> deleteByReference(DocumentReference reference) async {
    int result = await _todoService.deleteByReference(reference);

    return result;
  }
}
