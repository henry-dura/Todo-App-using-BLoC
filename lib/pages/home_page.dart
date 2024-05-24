import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';

import '../Models/task_model.dart';
import '../bloc/task_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    // Format the date as a string
    String formattedDate = DateFormat('EEEE, d MMMM').format(currentDate);

    final List<Task> tasks = [
      Task(name: 'practice coding', time: '4:30pm'),
      Task(name: 'Write Assignments', time: '1:30pm'),
      Task(name: 'practice Git', time: '7:30pm')
    ];

    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);

    return BlocConsumer<TaskBloc, TaskState>(
      listenWhen: (previous, current) => current is TaskActionState,
      listener: (context, state) {
        // TODO: implement listener


        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ModalSheetContents();
            });
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 35),
                  height: 200,
                  width: double.infinity,
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'Tasks(${tasks.length})',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.blue,
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(50))),
                      child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (BuildContext context, int index) {
                            final task = tasks[index];
                            return ListTile(
                              title: Text(
                                task.name,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    decoration: task.isChecked
                                        ? TextDecoration.lineThrough
                                        : null,
                                    decorationColor: Colors.red,
                                    decorationThickness: 3,
                                    fontStyle: task.isChecked
                                        ? FontStyle.italic
                                        : null),
                              ),
                              subtitle: Text(
                                task.time,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              trailing: Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  value: task.isChecked,
                                  onChanged: (_) {
                                    // taskData.changeStatus(task);
                                  },
                                ),
                              ),
                            );
                          })),
                )),
                FloatingActionButton(
                    child: Icon(
                      Icons.add,
                      size: 45,
                    ),
                    onPressed: () {

                      taskBloc.add(AddTaskButtonClicked());
                      // showModalBottomSheet(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return ModalSheetContents();
                      //     });
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}

class ModalSheetContents extends StatelessWidget {
  const ModalSheetContents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String newTask = '';
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add New Task',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter task here',
            ),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            onSubmitted: (val) {
              newTask = val;
            },
          ),
          TextField(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              // Set your desired background color here
            ),
            onPressed: () {
              print(newTask);
              Navigator.pop(context);
            },
            child: Text(
              'Add Task',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
