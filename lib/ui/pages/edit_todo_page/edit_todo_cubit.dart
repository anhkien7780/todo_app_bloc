import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_bloc/configs/app_configs.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/model/enums/category.dart';
import 'package:todo_app_bloc/model/enums/edit_todo_page_mode.dart';
import 'package:todo_app_bloc/repositories/todo_repository.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/edit_todo_navigator.dart';

import 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  EditTodoCubit({
    required this.repository,
    required this.navigator,
    required this.mode,
    Todo? todo,
  }) : super(EditTodoState(mode: mode)) {
    setTodo(todo);
  }

  final TodoRepository repository;
  final EditTodoNavigator navigator;
  final EditTodoPageMode mode;

  final dateTextController = TextEditingController();
  final timeTextController = TextEditingController();
  final taskTitleController = TextEditingController();
  final notesController = TextEditingController();

  void onTaskTitleChange(String taskTitle) {
    taskTitleController.text = taskTitle;
    emit(state.copyWith(taskTitle: taskTitle));
  }

  void setSelectedCategory(Category category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void setTodo(Todo? todo) {
    if (todo == null) return;

    dateTextController.text = todo.date != null
        ? DateFormat(AppConfigs.dateDisplayFormat).format(todo.date!)
        : "";

    timeTextController.text =
    todo.time != null ? DateFormat.jm().format(todo.time!) : "";

    taskTitleController.text = todo.taskTitle;
    notesController.text = todo.note ?? "";

    emit(
      state.copyWith(
        id: todo.id,
        date: todo.date,
        time: todo.time,
        taskTitle: todo.taskTitle,
        notes: todo.note,
        selectedCategory: todo.category,
        isCompleted: todo.isCompleted,
      ),
    );
  }

  void setDate(DateTime date) {
    dateTextController.text =
        DateFormat(AppConfigs.dateDisplayFormat).format(date);
    emit(state.copyWith(date: date));
  }

  void setTime(DateTime time) {
    timeTextController.text = DateFormat.jm().format(time);
    emit(state.copyWith(time: time));
  }

  void setTaskTitle(String taskTitle) {
    taskTitleController.text = taskTitle;
    emit(state.copyWith(taskTitle: taskTitle));
  }

  void setNotes(String notes) {
    notesController.text = notes;
    emit(state.copyWith(notes: notes));
  }

  void setMode(EditTodoPageMode mode) {
    emit(state.copyWith(mode: mode));
  }

  Todo getTodo() {
    return Todo(
      id: state.id,
      taskTitle: state.taskTitle,
      category: state.selectedCategory,
      date: state.date,
      time: state.time,
      note: state.notes,
      isCompleted: state.isCompleted,
    );
  }

  void onCloseButtonPressed() {
    navigator.navigatorPop(false);
  }

  Future<void> onSaveButtonPressed() async {
    if (state.taskTitle.trim().isEmpty) {
      return;
    }
    final todo = getTodo();
    if (state.mode == EditTodoPageMode.add) {
      await repository.addTodo(todo);
    } else {
      await repository.updateTodo(todo);
    }
    navigator.navigatorPop(true);
  }
}
