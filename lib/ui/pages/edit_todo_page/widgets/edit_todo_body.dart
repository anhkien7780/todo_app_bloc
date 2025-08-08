import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_svgs.dart';
import 'package:todo_app_bloc/configs/app_configs.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/edit_todo_cubit.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/edit_todo_state.dart';
import 'package:todo_app_bloc/ui/widgets/common/category_selector.dart';
import 'package:todo_app_bloc/ui/widgets/common/custom_text_field.dart';
import 'package:todo_app_bloc/ui/widgets/common/svg_image.dart';

class EditTodoBody extends StatefulWidget {
  const EditTodoBody({super.key});

  @override
  State<EditTodoBody> createState() => _EditTodoBodyState();
}

class _EditTodoBodyState extends State<EditTodoBody> {
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
                title: S.of(context).taskTitle,
                maxLines: 1,
                hint: S.of(context).taskTitle,
                onChange: (value) {
                  context.read<EditTodoCubit>().onTaskTitleChange(value);
                },
              ),
              BlocBuilder<EditTodoCubit, EditTodoState>(
                builder: (context, state) {
                  return CategorySelector(
                    selectedCategory: state.selectedCategory,
                    onChange: (category) {
                      context.read<EditTodoCubit>().setSelectedCategory(
                        category,
                      );
                    },
                  );
                },
              ),
              _buildDateTimeSelector(context: context),
              BlocBuilder<EditTodoCubit, EditTodoState>(
                builder: (context, state) {
                  return CustomTextField(
                    hint: S.of(context).notes,
                    title: S.of(context).notes,
                    borderColor: Colors.transparent,
                    height: AppDimens.textFieldHeightNormal,
                    onChange: (value) {
                      context.read<EditTodoCubit>().setNotes(value);
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
          child: BlocBuilder<EditTodoCubit, EditTodoState>(
            builder: (context, state) {
              final cubit = context.read<EditTodoCubit>();
              return CustomTextField(
                controller: cubit.dateTextController,
                hint: S.of(context).date,
                title: S.of(context).date,
                suffixIcon: IconButton(
                  onPressed: () {
                    _buildCupertinoDateTime(
                      context: context,
                      initialDateTime: dateTime,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (newDate) {
                        cubit.setDate(
                          DateFormat(
                            AppConfigs.dateDisplayFormat,
                          ).format(newDate),
                        );
                      },
                    );
                  },
                  icon: SizedBox(
                    height: AppDimens.iconSmallSize,
                    width: AppDimens.iconSmallSize,
                    child: SVGImage(imageUri: AppSvgs.icCalendar),
                  ),
                ),
                maxLines: 1,
              );
            },
          ),
        ),
        Flexible(
          child: BlocBuilder<EditTodoCubit, EditTodoState>(
            builder: (context, state) {
              final cubit = context.read<EditTodoCubit>();
              return CustomTextField(
                hint: S.of(context).time,
                title: S.of(context).time,
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
                    child: SVGImage(imageUri: AppSvgs.icClock),
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
