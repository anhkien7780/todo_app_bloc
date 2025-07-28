import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo_cubit.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo_state.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/widgets/add_todo_body.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/widgets/add_todo_header.dart';
import 'package:todo_app_bloc/ui/widgets/common/category_selector.dart';
import 'package:todo_app_bloc/ui/widgets/common/custom_text_field.dart';
import 'package:todo_app_bloc/ui/widgets/common/svg_image.dart';

class AddTodo extends StatelessWidget {
  final Function(Todo todo) onAddButtonPressed;

  const AddTodo({super.key, required this.onAddButtonPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Color(0xffF1F5F9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AddNewTaskScreenHeader(
                    onCloseButtonPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 24),
                  AddTodoBody(),
                  const SizedBox(height: 110),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: () {
                          final todo = context.read<AddTodoCubit>().getTodo();
                          if (todo.taskTitle.trim().isEmpty) {
                            ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                              const SnackBar(
                                content: Text("Task title is empty"),
                              ),
                            );
                          } else {
                            onAddButtonPressed(todo);
                            Navigator.of(context).pop();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color(0xff4A3780),
                          ),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


