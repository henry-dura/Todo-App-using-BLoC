import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../Models/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    // List<Task> tasks = [Task(name: 'Practice Coding', time: '4:30pm'),];
    on<LoadTaskEvent>((event, emit) {
      // TODO: implement event handler
      emit(TaskLoaded([
        Task(id: '1',name: 'Write Assignments', time: '1:30pm'),
      ]));
    });

    on<AddTaskEvent>((event, emit) {
      final state = this.state;
      if (state is TaskLoaded) {
        // final currentState = state as TaskLoaded;
        final updatedTask = List<Task>.from(state.tasks)
          ..add(event.newTask);
        emit(TaskLoaded(updatedTask));
      }
    });


  }
}

// [
// Task(name: 'practice coding', time: '4:30pm'),
// Task(name: 'Write Assignments', time: '1:30pm'),
// Task(name: 'practice Git', time: '7:30pm')
// ]

// on<AddTaskButtonClicked>((event, emit) {
// // TODO: implement event handler
// emit(AddTaskFloatButtonNavigate());
// });
