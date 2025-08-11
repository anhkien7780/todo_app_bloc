import 'package:uuid/uuid.dart';
import '../enums/category.dart';

class Todo {
  final String id;
  final String taskTitle;
  final Category category;
  final DateTime? date;
  final DateTime? time;
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
    DateTime? date,
    DateTime? time,
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
      date: json["date"] != null ? DateTime.parse(json["date"]) : null,
      time: json["time"] != null ? DateTime.parse(json["time"]) : null,
      note: json["note"],
      isCompleted: json["is_completed"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "task_title": taskTitle,
      "category": category.name,
      "date": date?.toIso8601String(),
      "time": time?.toIso8601String(),
      "note": note,
      "is_completed": isCompleted,
    };
  }
}
