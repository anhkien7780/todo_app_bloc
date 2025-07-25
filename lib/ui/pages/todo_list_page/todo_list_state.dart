import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/todo.dart';

class TodoListState extends Equatable {
  final List<Todo> unCompletedTodos;
  final List<Todo> completedTodos;

  const TodoListState({
    this.unCompletedTodos = const [],
    this.completedTodos = const [],
  });

  TodoListState copyWith({
    List<Todo>? unCompletedTodos,
    List<Todo>? completedTodos,
  }) {
    return TodoListState(
      unCompletedTodos: unCompletedTodos ?? this.unCompletedTodos,
      completedTodos: completedTodos ?? this.completedTodos,
    );
  }

  @override
  List<Object?> get props => [unCompletedTodos, completedTodos];
}
