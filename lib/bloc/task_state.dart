part of 'task_bloc.dart';

@immutable
sealed class TaskState extends Equatable{
  const TaskState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
sealed class TaskActionState extends TaskState{}

class AddTaskSuccess extends TaskActionState{}

class RemoveTaskSuccess extends TaskActionState{}

class TaskInitial extends TaskState{}

final class TaskLoaded extends TaskState {
  final List<Task> tasks ;
  const TaskLoaded( this.tasks);

  @override
  // TODO: implement props
  List<Object?> get props => [tasks];

  factory TaskLoaded.fromJson(Map<String, dynamic> json) {

    return TaskLoaded(
      (json['tasks'] as List).map((e) => Task.fromJson(e as Map<String, dynamic>)).toList(),
    );
    // return PendingTaskLoaded(
    //   (json['tasks'] as List).map((e) => Task.fromJson(e)).toList(),
    // );
  }

  Map<String, dynamic> toJson() {
    return {
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }

}




