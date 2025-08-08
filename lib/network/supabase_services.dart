import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app_bloc/configs/app_configs.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';

class SupabaseServices {
  static Future<Supabase> supabaseInit() async => await Supabase.initialize(
    url: AppConfigs.baseUrl,
    anonKey: TodoSupabaseConfig.anonKey,
  );

  static SupabaseClient supabaseClient = Supabase.instance.client;

  static Future<List<Todo>> fetchTodoList() async {
    try {
      final response = await supabaseClient.from("todos").select();
      final todos = response.map((todo) => Todo.fromJson(todo)).toList();
      return todos;
    } catch (e) {
      throw Exception("Fetch todo list is failed: ${e.toString()}");
    }
  }

  static Future<Todo> toggleCheckBox(Todo todo) async {
    try {
      final response = await supabaseClient
          .from("todos")
          .update({"is_completed": !todo.isCompleted})
          .eq("id", todo.id)
          .select();
      final todos = response.map((todo) => Todo.fromJson(todo)).toList();
      return todos[0];
    } catch (e) {
      throw Exception("Toggle check box is failed: ${e.toString()}");
    }
  }

  static Future<Todo> updateTodo(Todo todo) async {
    try {
      final response = await supabaseClient
          .from("todos")
          .update(todo.toJson())
          .eq("id", todo.id)
          .select();
      final todos = response.map((todo) => Todo.fromJson(todo)).toList();
      return todos[0];
    } catch (e) {
      throw Exception("Update todo is failed: ${e.toString()}");
    }
  }

  static Future<void> deleteTodo(Todo todo) async {
    try {
      await supabaseClient.from("todos").delete().eq("id", todo.id);
    } catch (e) {
      throw Exception("Delete todo is failed: ${e.toString()}");
    }
  }

  static Future<Todo> addTodo(Todo todo) async {
    try {
      final response = await supabaseClient.from("todos").insert(todo).select();
      final todos = response.map((todo) => Todo.fromJson(todo)).toList();
      return todos[0];
    } catch (e) {
      throw Exception("Add todo is failed: ${e.toString()}");
    }
  }
}
