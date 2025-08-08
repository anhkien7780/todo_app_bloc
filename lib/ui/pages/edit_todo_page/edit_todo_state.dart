import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/enums/category.dart';

class EditTodoState extends Equatable {
  final String taskTitle;
  final Category selectedCategory;
  final String? date;
  final String? time;
  final String? notes;

  const EditTodoState({
    this.taskTitle = "",
    this.selectedCategory = Category.task,
    this.date,
    this.time,
    this.notes,
  });

  EditTodoState copyWith({
    String? taskTitle,
    Category? selectedCategory,
    String? date,
    String? time,
    String? notes,
  }) {
    return EditTodoState(
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
