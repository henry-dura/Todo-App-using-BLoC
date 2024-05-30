part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class LoadTaskEvent extends TaskEvent {}

class TaskCheckedEvent extends TaskEvent{}

class AddTaskButtonClicked extends TaskEvent{}

class AddTaskEvent extends TaskEvent{
  final Task newTask;
   AddTaskEvent( this.newTask);

  @override
  // TODO: implement props
  List<Object?> get props => [newTask];
}

class RemoveTask extends TaskEvent{}

class EditTask extends TaskEvent{}