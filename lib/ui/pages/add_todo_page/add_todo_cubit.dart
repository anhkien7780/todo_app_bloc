import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/model/enums/category.dart';
import 'package:todo_app_bloc/repositories/todo_repository.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo_navigator.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit({required this.repository, required this.navigator})
    : super(AddTodoState());

  final TodoRepository repository;
  final AddTodoNavigator navigator;

  final dateTextController = TextEditingController();
  final timeTextController = TextEditingController();

  void onTaskTitleChange(String taskTitle) {
    emit(state.copyWith(taskTitle: taskTitle));
  }

  void setSelectedCategory(Category category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void setDate(String date) {
    dateTextController.text = date;
    emit(state.copyWith(date: date));
  }

  void setTime(String time) {
    timeTextController.text = time;
    emit(state.copyWith(time: time));
  }

  void setNotes(String notes) {
    emit(state.copyWith(notes: notes));
  }

  Todo getTodo() {
    final todo = Todo(
      taskTitle: state.taskTitle,
      category: state.selectedCategory,
      date: state.date,
      time: state.time,
      note: state.notes,
      isCompleted: false,
    );
    return todo;
  }

  void onCloseButtonPressed() {
    navigator.navigatorPop();
  }

  Future<void> onSaveButtonPressed() async {
    if (state.taskTitle.trim().isEmpty) {
      return;
    }
    final todo = Todo(
      taskTitle: state.taskTitle,
      category: state.selectedCategory,
      date: state.date,
      time: state.time,
      note: state.notes,
      isCompleted: false,
    );
    await repository.addTodo(todo);
    navigator.navigatorPop(true);
  }
}
