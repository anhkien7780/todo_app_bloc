import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo_cubit.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo_state.dart';
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
                  BlocProvider(
                    create: (BuildContext context) {
                      return AddTodoCubit();
                    },
                    child: AddTodoBody(),
                  ),
                  const SizedBox(height: 110),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: () {},
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

class AddTodoBody extends StatefulWidget {
  const AddTodoBody({super.key});

  @override
  State<AddTodoBody> createState() => _AddTodoBodyState();
}

class _AddTodoBodyState extends State<AddTodoBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Column(
            spacing: 24,
            children: [
              CustomTextField(
                title: "Task Title",
                maxLines: 1,
                hint: "Task Title",
                onChange: (value) {
                  context.read<AddTodoCubit>().onTaskTitleChange(value);
                },
              ),
              BlocBuilder<AddTodoCubit, AddTodoState>(
                builder: (context, state) {
                  return CategorySelector(
                    selectedCategory: state.selectedCategory,
                    onChange: (category) {
                      context.read<AddTodoCubit>().setSelectedCategory(
                        category,
                      );
                    },
                  );
                },
              ),
              _buildDateTimeSelector(context: context),
              BlocBuilder<AddTodoCubit, AddTodoState>(
                builder: (context, state) {
                  return CustomTextField(
                    hint: "Notes",
                    title: "Notes",
                    height: 177,
                    onChange: (value) {
                      context.read<AddTodoCubit>().setNotes(value);
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _buildCupertinoDateTime({
    required BuildContext context,
    required DateTime initialDateTime,
    required CupertinoDatePickerMode mode,
    required ValueChanged<DateTime> onDateTimeChanged,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 200,
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: initialDateTime,
            mode: mode,
            onDateTimeChanged: onDateTimeChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeSelector({required BuildContext context}) {
    DateTime dateTime = DateTime.now();
    return Row(
      spacing: 8,
      children: [
        BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            final cubit = context.read<AddTodoCubit>();
            return CustomTextField(
              controller: cubit.dateTextController,
              hint: "Date",
              title: "Date",
              width: 175,
              suffixIcon: IconButton(
                onPressed: () {
                  _buildCupertinoDateTime(
                    context: context,
                    initialDateTime: dateTime,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (newDate) {
                      cubit.setDate(
                        DateFormat("MMMM dd, yyyy").format(newDate),
                      );
                    },
                  );
                },
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: SVGImage(imageUri: "lib/assets/icons/ic_calendar.svg"),
                ),
              ),
              maxLines: 1,
            );
          },
        ),
        BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            final cubit = context.read<AddTodoCubit>();
            return CustomTextField(
              hint: "Time",
              title: "Time",
              controller: cubit.timeTextController,
              width: 175,
              suffixIcon: IconButton(
                onPressed: () {
                  _buildCupertinoDateTime(
                    context: context,
                    initialDateTime: dateTime,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (newTime) {
                      cubit.setTime(DateFormat.jm().format(newTime));
                    },
                  );
                },
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: SVGImage(imageUri: "lib/assets/icons/ic_clock.svg"),
                ),
              ),
              maxLines: 1,
            );
          },
        ),
      ],
    );
  }
}
