import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/task_bloc.dart';


class NewTaskForm extends StatefulWidget {
  final Function(String, String, String) onAddTask;
   const NewTaskForm({super.key, required this.onAddTask});

  @override
  State<NewTaskForm> createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _taskController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  late TimeOfDay _selectedTime;
  final _timeController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set initial time in controller after context is available
    _timeController.text = _selectedTime.format(context);
  }

  @override
  void dispose() {
    // Dispose the time controller
    super.dispose();
    _timeController.dispose();
    _taskController.dispose();
    _taskDescriptionController.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text =
            _selectedTime.format(context); // Update the text field
      });
    }
  }


  void _submit(){
    // Validate will return true if the form is valid, or false if the form is invalid.

    if (_formKey.currentState!
        .validate()) {
      final taskName = _taskController.text;
      final description = _taskDescriptionController.text;
      final time = _timeController.text;
      widget.onAddTask(taskName,description,time);

      _formKey.currentState?.reset();

      Navigator.pop(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    // TaskBloc taskBloc = BlocProvider.of<TaskBloc>(context);
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom:
                MediaQuery.of(context).viewInsets.bottom),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _taskController,
                      decoration: const InputDecoration(
                          hintText: 'Enter Task',
                          contentPadding:
                          EdgeInsets.symmetric(
                              horizontal: 12)),
                      validator: (value) =>
                      (value == null || value.isEmpty)
                          ? "Please enter a valid"
                          : null,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _taskDescriptionController,

                      decoration: const InputDecoration(
                          hintText: 'Enter Description',
                          contentPadding:
                          EdgeInsets.symmetric(
                              horizontal: 12)),
                      validator: (String? value) =>
                      (value == null || value.isEmpty)
                          ? 'Please Enter  Valid Desc'
                          : null,
                    ),
                    GestureDetector(
                      onTap: () => _selectTime(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _timeController,
                          decoration: const InputDecoration(
                            hintText: 'Select Time',
                          ),

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _submit();
                        },
                        child: const Text('Add Task'),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }


}
