import 'package:equatable/equatable.dart';
import '../../core/data/models/todo_model.dart';
// part of 'todo_cubit.dart';

// @immutable
sealed class TodoState extends Equatable{
  final List<TodoModel> todos;
  const TodoState(this.todos);
  @override
  List<Object?> get props => [todos] ;
}

final class TodoInitial extends TodoState {
  TodoInitial ():super([]);
}
class UpdateTodo extends TodoState{
  const UpdateTodo(super.todos);
}