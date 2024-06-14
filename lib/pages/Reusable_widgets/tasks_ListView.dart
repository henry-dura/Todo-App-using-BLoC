import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/task_bloc.dart';

class TasksListView extends StatelessWidget {
  List tasks;
  TasksListView({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);

    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          final task = tasks[index];
          return Card(
            child: ExpansionPanelList(
              expansionCallback: (int panelIndex, bool isExpanded) {
                taskBloc.add(ExpansionClicked(task.id));
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      leading: Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: task.isChecked,
                          onChanged: (_) {
                            taskBloc.add(CheckButtonClicked(task.id));
                          },
                        ),
                      ),
                      title: Text(
                        task.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          // decoration: task.isChecked
                          //     ? TextDecoration.lineThrough
                          //     : null,
                          // decorationColor: Colors.red,
                          // decorationThickness: 3,
                          // fontStyle: task.isChecked
                          //     ? FontStyle.italic
                          //     : null
                        ),
                      ),
                      subtitle: Text(
                        task.time,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      trailing: PopupMenuButton<int>(
                        child: const Icon(Icons.more_vert),
                        onSelected: (selected) {
                          if (selected == 1) {
                            taskBloc.add(RemoveTask(task.id));
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Delete'),
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Edit'),
                                Icon(Icons.edit, color: Colors.blue)
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  body: ListTile(
                    title: Text(
                      task.description,
                    ),
                  ),
                  isExpanded: task.isExpanded,
                )
              ],
            ),
          );
        });
  }
}
