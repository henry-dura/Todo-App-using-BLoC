import 'package:equatable/equatable.dart';

class Task {
  String id;
  String name;
  bool isChecked;
  String time;
  Task({required this.id, required this.name, this.isChecked = false,required this.time});

  // @override
  // // TODO: implement props
  // List<Object?> get props => [name,isChecked,time];
}