import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/common/app_dimens.dart';
import 'package:todo_app_bloc/common/app_svgs.dart';
import 'package:todo_app_bloc/common/app_text_styles.dart';
import 'package:todo_app_bloc/configs/app_configs.dart';
import 'package:todo_app_bloc/generated/l10n.dart';
import 'package:todo_app_bloc/model/entities/todo.dart';
import 'package:todo_app_bloc/model/enums/edit_todo_page_mode.dart';
import 'package:todo_app_bloc/repositories/todo_repository.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/edit_todo_cubit.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/edit_todo_navigator.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/widgets/edit_todo_header.dart';
import 'package:todo_app_bloc/ui/pages/edit_todo_page/widgets/category_selector.dart';
import 'package:todo_app_bloc/ui/widgets/text_fields/custom_text_field.dart';
import 'package:todo_app_bloc/ui/widgets/images/svg_image.dart';

import 'edit_todo_state.dart';

class EditTodoPage extends StatelessWidget {
  const EditTodoPage({super.key, this.todo, required this.mode});

  final EditTodoPageMode mode;
  final Todo? todo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditTodoCubit>(
      create: (BuildContext context) {
        return EditTodoCubit(
          repository: context.read<TodoRepository>(),
          navigator: EditTodoNavigator(context: context),
          mode: mode,
        );
      },
      child: EditTodoChildPage(todo: todo),
    );
  }
}

class EditTodoChildPage extends StatefulWidget {
  const EditTodoChildPage({super.key, this.todo});

  final Todo? todo;

  @override
  State<EditTodoChildPage> createState() => _EditTodoChildPageState();
}

class _EditTodoChildPageState extends State<EditTodoChildPage> {
  late EditTodoCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<EditTodoCubit>();
    _cubit.setTodo(widget.todo);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(
                        AppDimens.cornerRadiusNormal,
                      ),
                    ),
                    child: Column(
                      children: [
                        EditTodoHeader(
                          mode: _cubit.mode,
                          onCloseButtonPressed: () =>
                              _cubit.onCloseButtonPressed(),
                        ),
                        const SizedBox(height: AppDimens.marginLarge),
                        EditTodoBody(),
                        const Spacer(),
                        _buildSaveButton(context),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.marginNormal),
      child: SizedBox(
        width: double.infinity,
        height: AppDimens.buttonHeight,
        child: OutlinedButton(
          onPressed: () async {
            await _cubit.onSaveButtonPressed();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.buttonBGPrimary),
          ),
          child: Text(S.of(context).save, style: AppTextStyles.whiteS16Bold),
        ),
      ),
    );
  }
}

class EditTodoBody extends StatefulWidget {
  const EditTodoBody({super.key});

  @override
  State<EditTodoBody> createState() => _EditTodoBodyState();
}

class _EditTodoBodyState extends State<EditTodoBody> {
  late EditTodoCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<EditTodoCubit>();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditTodoCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingNormal),
      child: Column(
        children: [
          Column(
            spacing: AppDimens.marginLarge,
            children: [
              CustomTextField(
                controller: _cubit.taskTitleController,
                title: S.of(context).taskTitle,
                maxLines: 1,
                hint: S.of(context).taskTitle,
                onChange: (value) {
                  cubit.onTaskTitleChange(value);
                },
              ),
              BlocBuilder<EditTodoCubit, EditTodoState>(
                buildWhen: (prev, current) =>
                    prev.selectedCategory != current.selectedCategory,
                builder: (context, state) {
                  return CategorySelector(
                    selectedCategory: state.selectedCategory,
                    onChange: (category) {
                      cubit.setSelectedCategory(category);
                    },
                  );
                },
              ),
              _buildDateTimeSelector(context: context),
              BlocBuilder<EditTodoCubit, EditTodoState>(
                buildWhen: (prev, current) => prev.notes != current.notes,
                builder: (context, state) {
                  return CustomTextField(
                    controller: _cubit.notesController,
                    hint: S.of(context).notes,
                    title: S.of(context).notes,
                    borderColor: Colors.transparent,
                    height: AppDimens.textFieldHeightNormal,
                    onChange: (value) {
                      cubit.setNotes(value);
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
            minimumDate: AppConfigs.identityMinDate,
            maximumDate: AppConfigs.identityMaxDate,
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
        Flexible(// TODO: bo bloc build
          child: BlocBuilder<EditTodoCubit, EditTodoState>(
            buildWhen: (prev, current) => prev.date != current.date,
            builder: (context, state) {
              return CustomTextField(
                controller: context.read<EditTodoCubit>().dateTextController,
                hint: S.of(context).date,
                title: S.of(context).date,
                suffixIcon: IconButton(
                  onPressed: () {
                    _buildCupertinoDateTime(
                      context: context,
                      initialDateTime: dateTime,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (newDate) {
                        context.read<EditTodoCubit>().setDate(
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
            buildWhen: (prev, current) => prev.time != current.time,
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
