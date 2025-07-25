import 'package:uuid/uuid.dart';

import 'category.dart';


class Todo {
  final String id;
  final String taskTitle;
  final Category category;
  final String? date;
  final String? time;
  final String? note;
  final bool isCompleted;

  Todo({
    String? id,
    required this.taskTitle,
    required this.category,
    this.date,
    this.time,
    this.note,
    required this.isCompleted,
  }) : id = id ?? const Uuid().v4();

  Todo copyWith({
    String? id,
    String? taskTitle,
    Category? category,
    String? date,
    String? time,
    String? note,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      taskTitle: taskTitle ?? this.taskTitle,
      category: category ?? this.category,
      date: date ?? this.date,
      time: time ?? this.time,
      note: note ?? this.note,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json["id"],
      taskTitle: json["task_title"],
      category: CategoryExtension.fromString(json["category"]),
      date: json["date"],
      time: json["time"],
      note: json["note"],
      isCompleted: json["is_completed"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "task_title": taskTitle,
      "category": category.name,
      "date": date,
      "time": time,
      "note": note,
      "is_completed": isCompleted,
    };
  }
}
