import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/model/enums/category.dart';
import 'package:todo_app_bloc/model/enums/edit_todo_page_mode.dart';

class EditTodoState extends Equatable {
  final String? id;
  final String taskTitle;
  final Category selectedCategory;
  final DateTime? date;
  final DateTime? time;
  final String? notes;
  final EditTodoPageMode mode;
  final bool isCompleted;

  const EditTodoState({
    this.id,
    this.taskTitle = "",
    this.selectedCategory = Category.task,
    this.date,
    this.time,
    this.notes,
    this.mode = EditTodoPageMode.add,
    this.isCompleted = false,
  });

  EditTodoState copyWith({
    String? id,
    String? taskTitle,
    Category? selectedCategory,
    DateTime? date,
    DateTime? time,
    String? notes,
    EditTodoPageMode? mode,
    bool? isCompleted,
  }) {
    return EditTodoState(
      id: id ?? this.id,
      taskTitle: taskTitle ?? this.taskTitle,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      date: date ?? this.date,
      time: time ?? this.time,
      notes: notes ?? this.notes,
      mode: mode ?? this.mode,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
    id,
    taskTitle,
    selectedCategory,
    date,
    time,
    notes,
    mode,
    isCompleted,
  ];
}
