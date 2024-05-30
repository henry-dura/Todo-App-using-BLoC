import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../Models/task_model.dart';
import '../bloc/task_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(LoadTaskEvent());
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    // Format the date as a string
    String formattedDate = DateFormat('EEEE, d MMMM').format(currentDate);

    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);

    return BlocConsumer<TaskBloc, TaskState>(
      listenWhen: (previous, current) => current is TaskActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is AddTaskFloatButtonNavigate) {
          // showModalBottomSheet(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return Container(
          //         padding: EdgeInsets.all(20),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text(
          //               'Add New Task',
          //               style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
          //             ),
          //             TextField(
          //               decoration: InputDecoration(
          //                 hintText: 'Enter task here',
          //               ),
          //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //               onSubmitted: (val) {
          //                 // newTask = val;
          //               },
          //             ),
          //             TextField(),
          //             ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                 backgroundColor: Colors.blue,
          //                 // Set your desired background color here
          //               ),
          //               onPressed: () {
          //                 taskBloc.add(AddTaskEvent(Task(name: 'Added newly', time: '9:30pm'),));
          //                 // print(newTask);
          //                 Navigator.pop(context);
          //               },
          //               child: Text(
          //                 'Add Task',
          //                 style: TextStyle(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 20),
          //               ),
          //             )
          //           ],
          //         ),
          //       );
          //     });
        }
      },
      builder: (context, state) {
        if (state is TaskLoaded) {
          final successState = state as TaskLoaded;
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
                          'Tasks(${successState.tasks.length})',
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
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(50))),
                        child: ListView.builder(
                            itemCount: successState.tasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              final task = successState.tasks;
                              return ListTile(
                                title: Text(
                                  task[index].name,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      decoration: task[index].isChecked
                                          ? TextDecoration.lineThrough
                                          : null,
                                      decorationColor: Colors.red,
                                      decorationThickness: 3,
                                      fontStyle: task[index].isChecked
                                          ? FontStyle.italic
                                          : null),
                                ),
                                subtitle: Text(
                                  task[index].time,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                    value: task[index].isChecked,
                                    onChanged: (_) {
                                      setState(() {
                                        !(task[index].isChecked);
                                      });
                                    },
                                  ),
                                ),
                              );
                            })),
                  )),
                  FloatingActionButton(
                      child: const Icon(
                        Icons.add,
                        size: 45,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Add New Task',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Enter task here',
                                      ),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      onSubmitted: (val) {
                                        // newTask = val;
                                      },
                                    ),
                                    TextField(),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        // Set your desired background color here
                                      ),
                                      onPressed: () {
                                        taskBloc.add(AddTaskEvent(
                                          Task(
                                            id: '2',
                                              name: 'Added newly',
                                              time: '9:30pm'),
                                        ));
                                        // print(newTask);
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
                            });
                      })
                ],
              ),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

class ModalSheetContents extends StatelessWidget {
  const ModalSheetContents({super.key, this.taskAction});

  final taskAction;

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
              taskAction;
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
