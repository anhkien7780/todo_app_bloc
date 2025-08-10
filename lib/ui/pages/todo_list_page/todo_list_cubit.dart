import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';
import 'package:todo_app_bloc/network/supabase_services.dart';
import 'package:todo_app_bloc/repositories/todo_repository.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_navigator.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit({required this.repository, required this.navigator})
    : super(const TodoListState());

  final TodoRepository repository;
  final TodoListNavigator navigator;

  void fetchTodos() async {
    if (state.loadTodoStatus == LoadStatus.loading) {
      return;
    }
    emit(state.copyWith(loadTodoStatus: LoadStatus.loading));
    try {
      final todos = await repository.fetchTodos();
      final uncompletedTodo = todos.where((todo) => !todo.isCompleted).toList();
      final completedTodo = todos.where((todo) => todo.isCompleted).toList();
      emit(
        state.copyWith(
          loadTodoStatus: LoadStatus.success,
          unCompletedTodos: uncompletedTodo,
          completedTodos: completedTodo,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadTodoStatus: LoadStatus.failure));
    }
  }

  void handleResultFromEditTodoPage(bool? result) {
    if (result != true) {
      return;
    }
    fetchTodos();
  }

  void toggleCheckBox(Todo todo) async {
    final toggledTodo = await repository.toggleCheckBox(todo);
    final newCompleted = List<Todo>.from(state.completedTodos);
    final newUnCompleted = List<Todo>.from(state.unCompletedTodos);
    if (todo.isCompleted) {
      newCompleted.remove(todo);
      newUnCompleted.add(toggledTodo);
    } else {
      newUnCompleted.remove(todo);
      newCompleted.add(toggledTodo);
    }
    emit(
      state.copyWith(
        unCompletedTodos: newUnCompleted,
        completedTodos: newCompleted,
      ),
    );
  }

  void deleteTodo(Todo todo) async {
    await SupabaseServices.deleteTodo(todo);
    if (todo.isCompleted) {
      final newCompleted = List<Todo>.from(state.completedTodos);
      newCompleted.remove(todo);
      emit(state.copyWith(completedTodos: newCompleted));
    } else {
      final newUnCompleted = List<Todo>.from(state.unCompletedTodos);
      newUnCompleted.remove(todo);
      emit(state.copyWith(unCompletedTodos: newUnCompleted));
    }
  }
}
