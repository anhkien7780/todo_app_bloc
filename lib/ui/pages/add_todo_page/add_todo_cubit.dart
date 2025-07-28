import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/ui/pages/add_todo_page/add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState>{
  AddTodoCubit() : super(AddTodoState());

}