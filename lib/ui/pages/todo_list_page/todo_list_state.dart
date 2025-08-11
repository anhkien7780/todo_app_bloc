import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';

class TodoListState extends Equatable {
  final LoadStatus loadTodoStatus;
  final List<Todo> unCompletedTodos;
  final List<Todo> completedTodos;

  const TodoListState({
    this.loadTodoStatus = LoadStatus.initial,
    this.unCompletedTodos = const [],
    this.completedTodos = const [],
  });

  TodoListState copyWith({
    LoadStatus? loadTodoStatus,
    List<Todo>? unCompletedTodos,
    List<Todo>? completedTodos,
  }) {
    return TodoListState(
      loadTodoStatus: loadTodoStatus ?? this.loadTodoStatus,
      unCompletedTodos: unCompletedTodos ?? this.unCompletedTodos,
      completedTodos: completedTodos ?? this.completedTodos,
    );
  }

  @override
  List<Object?> get props => [loadTodoStatus, unCompletedTodos, completedTodos];
}
