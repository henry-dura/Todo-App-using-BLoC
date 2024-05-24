part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class AddTaskButtonClicked extends TaskEvent{}
class AddTask extends TaskEvent{}

class RemoveTask extends TaskEvent{}

class EditTask extends TaskEvent{}