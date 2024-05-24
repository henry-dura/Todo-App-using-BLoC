import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Models/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    // on<TaskEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<AddTaskButtonClicked>((event, emit) {
      // TODO: implement event handler
      print('working fine');
      emit(AddTaskFloatButtonNavigate());

    });
  }
}
