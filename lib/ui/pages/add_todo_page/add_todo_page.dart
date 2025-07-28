import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/model/enums/category.dart';
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
                  _buildBody(context: context),
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

  Widget _buildBody({required BuildContext context}) {
    DateTime dateTime = DateTime.now();

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
                onChange: (value) {},
              ),
              CategorySelector(
                selectedCategory: Category.task,
                onChange: (category) {},
              ),

              Row(
                spacing: 8,
                children: [
                  CustomTextField(
                    controller: TextEditingController(),
                    hint: "Date",
                    title: "Date",
                    onChange: (newDate) {},
                    width: 175,
                    suffixIcon: IconButton(
                      onPressed: () {
                        _buildCupertinoDateTime(
                          context,
                          dateTime,
                          CupertinoDatePickerMode.date,
                          (newDate) {},
                        );
                      },
                      icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: SVGImage(
                          imageUri: "lib/assets/icons/ic_calendar.svg",
                        ),
                      ),
                    ),
                    maxLines: 1,
                  ),
                  CustomTextField(
                    hint: "Time",
                    title: "Time",
                    controller: TextEditingController(),
                    onChange: (value) {},
                    width: 175,
                    suffixIcon: IconButton(
                      onPressed: () {
                        _buildCupertinoDateTime(
                          context,
                          dateTime,
                          CupertinoDatePickerMode.time,
                          (newTime) {},
                        );
                      },
                      icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: SVGImage(
                          imageUri: "lib/assets/icons/ic_clock.svg",
                        ),
                      ),
                    ),
                    maxLines: 1,
                  ),
                ],
              ),

              CustomTextField(
                hint: "Notes",
                title: "Notes",
                height: 177,
                onChange: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _buildCupertinoDateTime(
    BuildContext context,
    DateTime initialDateTime,
    CupertinoDatePickerMode mode,
    ValueChanged<DateTime> onDateTimeChanged,
  ) {
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
}
