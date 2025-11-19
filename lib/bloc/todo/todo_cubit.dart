import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myproject/bloc/todo/todo_state.dart';
import 'package:myproject/core/data/models/todo_model.dart';
import 'package:uuid/uuid.dart';
// part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  void addToDo (String title){
    TodoModel task = TodoModel(id:DateTime.now().millisecondsSinceEpoch, title: title, isCompleted: false);
    emit(UpdateTodo([...state.todos , task]));
  }

  void removeToDo (int id){
      final List<TodoModel> newTodos = state.todos.where((item)=> item.id != id).toList();
      emit(UpdateTodo(newTodos));
  }

  void toggleTask (int id){
      final List <TodoModel> newTodos = state.todos.map((item) {
        return item.id == id ? item.copyWith(isCompleted : !item.isCompleted) : item;
      }).toList();

      emit(UpdateTodo(newTodos));
  }
 }
