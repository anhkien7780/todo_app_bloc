import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_svgs.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo_cubit.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo_state.dart';
import 'package:todo_app_bloc/ui/widgets/common/category_selector.dart';
import 'package:todo_app_bloc/ui/widgets/common/custom_text_field.dart';
import 'package:todo_app_bloc/ui/widgets/common/svg_image.dart';

class AddTodoBody extends StatefulWidget {
  const AddTodoBody({super.key});

  @override
  State<AddTodoBody> createState() => _AddTodoBodyState();
}

class _AddTodoBodyState extends State<AddTodoBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingNormal),
      child: Column(
        children: [
          Column(
            spacing: AppDimens.marginLarge,
            children: [
              CustomTextField(
                title: "Task Title",
                maxLines: 1,
                hint: "Task Title",
                onChange: (value) {
                  context.read<AddTodoCubit>().onTaskTitleChange(value);
                },
              ),
              BlocBuilder<AddTodoCubit, AddTodoState>(
                builder: (context, state) {
                  return CategorySelector(
                    selectedCategory: state.selectedCategory,
                    onChange: (category) {
                      context.read<AddTodoCubit>().setSelectedCategory(
                        category,
                      );
                    },
                  );
                },
              ),
              _buildDateTimeSelector(context: context),
              BlocBuilder<AddTodoCubit, AddTodoState>(
                builder: (context, state) {
                  return CustomTextField(
                    hint: "Notes",
                    title: "Notes",
                    borderColor: Colors.transparent,
                    height: AppDimens.textFieldHeightNormal,
                    onChange: (value) {
                      context.read<AddTodoCubit>().setNotes(value);
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _buildCupertinoDateTime({
    required BuildContext context,
    required DateTime initialDateTime,
    required CupertinoDatePickerMode mode,
    required ValueChanged<DateTime> onDateTimeChanged,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: AppDimens.cupertinoModelPopupHeight,
        color: AppColors.textWhite,
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

  Widget _buildDateTimeSelector({required BuildContext context}) {
    DateTime dateTime = DateTime.now();
    return Row(
      spacing: AppDimens.marginSmaller,
      children: [
        Flexible(
          child: BlocBuilder<AddTodoCubit, AddTodoState>(
            builder: (context, state) {
              final cubit = context.read<AddTodoCubit>();
              return CustomTextField(
                controller: cubit.dateTextController,
                hint: "Date",
                title: "Date",
                suffixIcon: IconButton(
                  onPressed: () {
                    _buildCupertinoDateTime(
                      context: context,
                      initialDateTime: dateTime,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (newDate) {
                        cubit.setDate(
                          DateFormat("MMMM dd, yyyy").format(newDate),
                        );
                      },
                    );
                  },
                  icon: SizedBox(
                    height: AppDimens.iconSmallSize,
                    width: AppDimens.iconSmallSize,
                    child: SVGImage(imageUri: AppImages.icCalendar),
                  ),
                ),
                maxLines: 1,
              );
            },
          ),
        ),
        Flexible(
          child: BlocBuilder<AddTodoCubit, AddTodoState>(
            builder: (context, state) {
              final cubit = context.read<AddTodoCubit>();
              return CustomTextField(
                hint: "Time",
                title: "Time",
                controller: cubit.timeTextController,
                suffixIcon: IconButton(
                  onPressed: () {
                    _buildCupertinoDateTime(
                      context: context,
                      initialDateTime: dateTime,
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (newTime) {
                        cubit.setTime(DateFormat.jm().format(newTime));
                      },
                    );
                  },
                  icon: SizedBox(
                    height: AppDimens.iconSmallSize,
                    width: AppDimens.iconSmallSize,
                    child: SVGImage(imageUri: AppImages.icClock),
                  ),
                ),
                maxLines: 1,
              );
            },
          ),
        ),
      ],
    );
  }
}
