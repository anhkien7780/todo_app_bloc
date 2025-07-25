import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';

class SupabaseServices {
  static final String _url = "https://ijywzybzbkkqtlqrwkiu.supabase.co";
  static final String _anonKey = dotenv.env["SUPABASE_API_KEY"] ?? "";

  static Future<Supabase> supabaseInit() async =>
      await Supabase.initialize(url: _url, anonKey: _anonKey);

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
}
