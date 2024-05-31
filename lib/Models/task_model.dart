import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Task {
  String id;
  String name;
  String description;
  bool isChecked;
  bool isExpanded;
  String time;
  Task({ required this.name, this.isChecked = false,this.isExpanded = false,required this.time, required this.description}):id = Uuid().v4();

  void toggleCheck(){
    isChecked = !isChecked;
  }

  Task copyWith({
    String? id,
    String ?description,
    String? name,
    bool? isChecked,
    bool? isExpanded,
    String ?time,
  }) {
    return Task(
      name: name ?? this.name,
      isChecked: isChecked ?? this.isChecked,
      isExpanded: isExpanded ?? this.isExpanded,
      description: description??this.description,
      time: time??this.time,

    );
  }

  // @override
  // // TODO: implement props
  // List<Object?> get props => [name,isChecked,time];
}