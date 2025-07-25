import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_app_bloc/network/supabase_services.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_cubit.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SupabaseServices.supabaseInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return TodoListCubit();
          },
        ),
      ],
      child: MaterialApp(home: TodoListPage()),
    );
  }
}
