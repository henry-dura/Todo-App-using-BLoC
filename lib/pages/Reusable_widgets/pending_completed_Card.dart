import 'package:flutter/material.dart';

import '../../Models/task_model.dart';

class PendingCompletedCard extends StatelessWidget {
  const PendingCompletedCard({
    super.key,
    required this.pendingTasks,
    required this.completedTasks,
  });

  final List<Task> pendingTasks;
  final List<Task> completedTasks;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 25,
      shadowColor: Colors.brown,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '(${pendingTasks.length})Pending /',
              style: const TextStyle(
                  fontSize: 25, color: Colors.white),
            ),
            Text(
              'Completed(${completedTasks.length})',
              style: const TextStyle(
                  fontSize: 25, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

