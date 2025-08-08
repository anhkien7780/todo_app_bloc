import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/network/supabase_services.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();

  Future<Todo> addTodo(Todo todo);

  Future<Todo> updateTodo(Todo todo);

  Future<void> removeTodo(Todo todo);

  Future<Todo> toggleCheckBox(Todo todo);
}

class TodoRepositoryImpl extends TodoRepository {
  @override
  Future<Todo> addTodo(Todo todo) {
    return SupabaseServices.addTodo(todo);
  }

  @override
  Future<Todo> updateTodo(Todo todo) {
    return SupabaseServices.updateTodo(todo);
  }

  @override
  Future<List<Todo>> fetchTodos() {
    return SupabaseServices.fetchTodoList();
  }

  @override
  Future<void> removeTodo(Todo todo) {
    return SupabaseServices.deleteTodo(todo);
  }

  @override
  Future<Todo> toggleCheckBox(Todo todo) {
    return SupabaseServices.toggleCheckBox(todo);
  }
}
