import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../Models/task_model.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskLoaded([])) {
    // List<Task> tasks = [Task(name: 'Practice Coding', time: '4:30pm'),];

    // on<LoadTaskEvent>((event, emit) {
    //   // TODO: implement event handler
    //   final state = this.state;
    //   if(state is PendingTaskLoaded){
    //     state.tasks = <Task>[];
    //     emit(PendingTaskLoaded(state.tasks));
    //
    //   }
    //
    // });

    on<CheckButtonClicked>((event, emit) {
      // TODO: implement event handler
      final state = this.state;
      if(state is TaskLoaded){
        List<Task> updateChecked = state.tasks.map((task) => task.id == event.id? task.copyWith(isChecked: !task.isChecked):task).toList();
        emit(TaskLoaded(updateChecked));
      }
    });

    on<ExpansionClicked>((event, emit) {
      // TODO: implement event handler
      final state = this.state;
      if(state is TaskLoaded){
        List<Task> updateExpansion = state.tasks.map((task) => task.id == event.id? task.copyWith(isExpanded: !task.isExpanded):task).toList();
        emit(TaskLoaded(updateExpansion));
      }
    });

    on<AddTaskEvent>((event, emit) {
      final state = this.state;
      if (state is TaskLoaded) {
        // final currentState = state as TaskLoaded;
        final updatedTask = List<Task>.from(state.tasks)
          ..add(event.newTask);
        emit(AddTaskSuccess());
        emit(TaskLoaded(updatedTask));
      }
    });

    on<RemoveTask>((event, emit) {
// TODO: implement event handler
    final state = this.state;
    if(state is TaskLoaded){
      List<Task>unDeletedTasks = state.tasks.where((task) => task.id != event.id).toList();
      emit(RemoveTaskSuccess());
      emit(TaskLoaded(unDeletedTasks));
    }
    });


  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    if (state is TaskLoaded) {

      // return  PendingTaskLoaded.fromJson(json);

      try {
        return TaskLoaded.fromJson(json);
      } catch (_) {
        return null;
      }
    }
    return null;

    // try {
    //   final tasks = (json['tasks'] as List).map((e) => Task.fromJson(e)).toList();
    //   return PendingTaskLoaded(tasks);
    // } catch (_) {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    // TODO: implement toJson
    if (state is TaskLoaded) {
      return state.toJson();
    }
    return null;
  }

}


