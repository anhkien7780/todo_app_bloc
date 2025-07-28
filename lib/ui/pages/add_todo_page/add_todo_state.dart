import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/enums/category.dart';

class AddTodoState extends Equatable {
  final String taskTitle;
  final Category selectedCategory;
  final String? date;
  final String? time;
  final String? notes;

  const AddTodoState({
    this.taskTitle = "",
    this.selectedCategory = Category.task,
    this.date,
    this.time,
    this.notes,
  });

  AddTodoState copyWith({
    String? taskTitle,
    Category? selectedCategory,
    String? date,
    String? time,
    String? notes,
  }) {
    return AddTodoState(
      taskTitle: taskTitle ?? this.taskTitle,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      date: date,
      time: time,
      notes: notes,
    );
  }

  @override
  List<Object?> get props => [taskTitle, selectedCategory, date, time, notes];
}
