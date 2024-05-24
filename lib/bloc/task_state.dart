part of 'task_bloc.dart';

@immutable
sealed class TaskState {}
sealed class TaskActionState extends TaskState{}


class AddTaskFloatButtonNavigate extends TaskActionState{}

class TaskAddedNotificationSnackBar extends TaskActionState{}

class TaskRemovedNotificationSnackBar extends TaskActionState{}



final class TaskInitial extends TaskState {}

class TaskAddedSuccessful extends TaskState{
   Task task;
   TaskAddedSuccessful(@required this.task);
}


class TaskAddingError extends TaskState{}
