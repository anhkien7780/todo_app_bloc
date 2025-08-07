import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/repositories/todo_repository.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_cubit.dart';
import 'package:todo_app_bloc/ui/pages/todo_list_page/todo_list_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TodoRepository>(
      create: (BuildContext context) {
        return TodoRepositoryImpl();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TodoListCubit>(
            create: (context) {
              final todoRepo = RepositoryProvider.of<TodoRepository>(context);
              return TodoListCubit(todoRepository: todoRepo);
            },
          ),
        ],
        child: MaterialApp(home: TodoListPage()),
      ),
    );
  }
}
