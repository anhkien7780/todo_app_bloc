import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/model/enums/load_status.dart';
import 'package:todo_app_bloc/network/supabase_services.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(const TodoListState());

  void fetchTodos() async {
    if (state.loadTodoStatus == LoadStatus.loading) {
      return;
    }
    emit(state.copyWith(loadTodoStatus: LoadStatus.loading));
    try {
      final todos = await SupabaseServices.fetchTodoList();
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

  void toggleCheckBox(Todo todo) async {
    final toggledTodo = await SupabaseServices.toggleCheckBox(todo);
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

  void addTodo(Todo todo) async {
    final addedTodo = await SupabaseServices.addTodo(todo);
    final newUnCompleted = List<Todo>.from(state.unCompletedTodos);
    final newCompleted = List<Todo>.from(state.completedTodos);
    newUnCompleted.add(addedTodo);
    emit(state.copyWith(unCompletedTodos: newUnCompleted, completedTodos: newCompleted));
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
