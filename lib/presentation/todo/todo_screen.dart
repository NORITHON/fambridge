import 'package:complete_advanced_flutter/controller/todo_controller.dart';
import 'package:complete_advanced_flutter/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: todoController.getStream(),
          builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
              return LinearProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Todo todo = snapshot.data![index];
                return Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: InkWell(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Text(todo.title!),
                                Text(todo.content!),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            print("push update");
                            print(todo.done);
                            todo.reference!.update({"done": !todo.done!});
                          },
                          icon: todo.done!
                              ? Icon(Icons.check)
                              : Icon(Icons.cancel),
                        ),
                        IconButton(
                          onPressed: () {
                            print("onPressed : ${todo.id!}");
                            // todoController.deleteById(todo.id!);
                            todoController.deleteByReference(todo.reference!);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
