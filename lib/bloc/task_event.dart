part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class LoadTaskEvent extends TaskEvent {}

class TaskCheckedEvent extends TaskEvent{}

class AddTaskButtonClicked extends TaskEvent{}

class CheckButtonClicked extends TaskEvent{
  String id;
  CheckButtonClicked( this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class ExpansionClicked extends TaskEvent{
  String id;
  ExpansionClicked( this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class AddTaskEvent extends TaskEvent{
  final Task newTask;
   AddTaskEvent( this.newTask);

  @override
  // TODO: implement props
  List<Object?> get props => [newTask];
}

class RemoveTask extends TaskEvent{
  String id;
  RemoveTask( this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class EditTask extends TaskEvent{}