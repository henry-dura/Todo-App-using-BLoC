import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';


class Task extends Equatable {
  String id;
  final String name;
  final String description;
  bool isChecked;
  bool isExpanded;
  final String time;
  Task({ required this.name, this.isChecked = false,this.isExpanded = false,required this.time, required this.description}):id = const Uuid().v4();



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
    )..id = id ?? this.id;
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'],
      description: json['description'],
      isChecked: json['isChecked'],
      isExpanded: json['isExpanded'],
      time: json['time'],
    )..id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isChecked': isChecked,
      'isExpanded': isExpanded,
      'time': time,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,description,isChecked,isExpanded,time];



}