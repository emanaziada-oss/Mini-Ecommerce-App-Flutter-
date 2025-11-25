import 'package:myproject/core/data/models/todo_model.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final List todos = <TodoModel>[].obs;

  void addToDo(String title) {
    final todo = TodoModel(
      id: "${DateTime.now().microsecondsSinceEpoch}",
      title: title,
      isCompleted: false,
    );
    todos.add(todo);
  }

  void removeTodo(int id) {
    todos.removeWhere((todo) => todo.id == id);
  }

  void toggleTask(int id) {
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      todos[index] = todos[index].copyWith(
        isCompleted: !todos[index].isCompleted,
      );
    }
  }
}
