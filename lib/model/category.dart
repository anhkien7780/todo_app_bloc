enum Category { task, event, goal }

extension CategoryExtension on Category {
  static Category fromString(String categoryString) {
    return Category.values.firstWhere(
      (element) => element.name == categoryString,
      orElse: () => Category.task,
    );
  }
}
