// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addNewTask": MessageLookupByLibrary.simpleMessage("Thêm công việc mới"),
    "cancel": MessageLookupByLibrary.simpleMessage("Từ chối"),
    "category": MessageLookupByLibrary.simpleMessage("Danh mục"),
    "completed": MessageLookupByLibrary.simpleMessage("Hoàn thành"),
    "confirm": MessageLookupByLibrary.simpleMessage("Đồng ý"),
    "date": MessageLookupByLibrary.simpleMessage("Ngày"),
    "delete": MessageLookupByLibrary.simpleMessage("Xoá"),
    "deleteDialogTitle": MessageLookupByLibrary.simpleMessage(
      "Bạn chắc chắn muốn xoá công việc này?",
    ),
    "editTask": MessageLookupByLibrary.simpleMessage("Sửa công việc"),
    "failedToLoadTodos": MessageLookupByLibrary.simpleMessage(
      "Tải danh sách việc làm thất bại",
    ),
    "myTodoList": MessageLookupByLibrary.simpleMessage("Danh sách việc làm"),
    "notes": MessageLookupByLibrary.simpleMessage("Ghi chú"),
    "save": MessageLookupByLibrary.simpleMessage("Lưu"),
    "taskIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Công việc trống.\nVui lòng thêm công việc mới!",
    ),
    "taskTitle": MessageLookupByLibrary.simpleMessage("Tiêu đề"),
    "taskTitleIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Tiêu đề không được để trống",
    ),
    "time": MessageLookupByLibrary.simpleMessage("Thời gian"),
  };
}
