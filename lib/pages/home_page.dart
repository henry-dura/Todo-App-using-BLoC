import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import '../Models/task_model.dart';
import '../bloc/task_bloc.dart';
import 'Reusable_widgets/new_task_form.dart';
import 'Reusable_widgets/pending_completed_Card.dart';
import 'Reusable_widgets/snack_bar.dart';
import 'Reusable_widgets/tasks_ListView.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool checkDisplayFloatButton() => (_selectedIndex == 0) ? true:false;

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    // Format the date as a string
    String formattedDate = DateFormat('EEEE, d MMMM').format(currentDate);

    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);

    return BlocConsumer<TaskBloc, TaskState>(
      listenWhen: (previous, current) => current is TaskActionState,
      buildWhen: (prev, current) => current is! TaskActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is AddTaskSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snack('Task Added Successfully', Colors.green));
        } else if (state is RemoveTaskSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snack('Task Removed Successfully', Colors.red));
        }
      },
      builder: (context, state) {
        if (state is TaskLoaded) {
          final pendingTasks = state.tasks.where((task) => !task.isChecked).toList();
          final completedTasks = state.tasks.where((task) => task.isChecked).toList();
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 35),
                    height: 200,
                    width: double.infinity,
                    color: Colors.blue,
                    child: Column(
                      children: [
                        Text(
                          formattedDate,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w900),
                        ),
                        PendingCompletedCard(pendingTasks: pendingTasks, completedTasks: completedTasks)
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                        color: Colors.blue,
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.shade100,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(50))),
                            child:  IndexedStack(
                              index: _selectedIndex,
                              children: [
                                TasksListView(tasks: pendingTasks,),
                                TasksListView(tasks: completedTasks,),
                              ],
                            ),),
                      )),
                ],
              ),

              floatingActionButton: checkDisplayFloatButton()
                  ? FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) => NewTaskForm(
                          onAddTask: (taskName, description, time) {
                            taskBloc.add(AddTaskEvent(Task(
                              name: taskName,
                              time: time,
                              description: description,
                            )));
                          },
                        ));
                  },
                  child: const Icon(
                    Icons.add,
                    size: 45,
                    color: Colors.white,
                  ))
                  : null,
        bottomNavigationBar: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 8),
              child: bottomNavigator(),
            ),
          ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }




  GNav bottomNavigator() {
    return GNav(
              tabBackgroundColor: Colors.blue.shade400,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,

              iconSize: 35,
              padding: const EdgeInsets.all(8),
              gap:10,
              tabs: const [
                GButton(
                  icon: Icons.incomplete_circle_rounded,
                  text: 'PENDING',
                ),
                GButton(
                  icon: Icons.check,
                  text: 'COMPLETED',
                ),

              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index){
                setState(() {
                  _selectedIndex = index;
                });
              },
            );
  }



  }

