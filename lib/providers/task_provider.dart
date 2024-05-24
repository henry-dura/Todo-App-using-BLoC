import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../Models/task_model.dart';

class TaskProvider extends ChangeNotifier{
  final List<Task> _tasks= [Task(name:'practice coding',time: '4:30pm'), Task(name:'Write Assignments',time: '1:30pm'),Task(name:'practice Git',time: '7:30pm')];
  List get tasks => _tasks;

  void changeStatus(Task task){
    task.isChecked = ! task.isChecked ;
    notifyListeners();
  }

  void addTask(){
    _tasks.add(Task(name:'Practice Dart',time: '5:30am'));
    notifyListeners();
  }
}