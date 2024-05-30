part of 'task_bloc.dart';

@immutable
sealed class TaskState extends Equatable{
  const TaskState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
sealed class TaskActionState extends TaskState{}

class TaskInitial extends TaskState{}

final class TaskLoaded extends TaskState {
  final List<Task> tasks;
  const TaskLoaded( this.tasks);

  @override
  // TODO: implement props
  List<Object?> get props => [tasks];
}


class AddTaskFloatButtonNavigate extends TaskActionState{}

// class TaskAddedNotificationSnackBar extends TaskActionState{}
//
// class TaskRemovedNotificationSnackBar extends TaskActionState{}







// class TaskAddedSuccessful extends TaskState{
//    Task task;
//    TaskAddedSuccessful(@required this.task);
// }
//
//
// class TaskAddingError extends TaskState{}
