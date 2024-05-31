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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _taskController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  late TimeOfDay _selectedTime;
  final _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(LoadTaskEvent());
    _selectedTime = TimeOfDay.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set initial time in controller after context is available
    _timeController.text = _selectedTime!.format(context);
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
            _selectedTime!.format(context); // Update the text field
      });
    }
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
                              final task = successState.tasks[index];
                              return ExpansionPanelList(
                                expansionCallback:
                                    (int panelIndex, bool isExpanded) {
                                  taskBloc.add(ExpansionClicked(task.id));
                                },
                                children: [
                                  ExpansionPanel(
                                    headerBuilder: (BuildContext context,
                                        bool isExpanded) {
                                      return ListTile(
                                        title: Text(task.name),
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
                                              taskBloc.add(CheckButtonClicked(task.id));
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    body: ListTile(
                                      title: Text(
                                        task.description,
                                        // style: TextStyle(
                                        //     fontSize: 25,
                                        //     fontWeight: FontWeight.w700,
                                        //     decoration: task.isChecked
                                        //         ? TextDecoration.lineThrough
                                        //         : null,
                                        //     decorationColor: Colors.red,
                                        //     decorationThickness: 3,
                                        //     fontStyle: task.isChecked
                                        //         ? FontStyle.italic
                                        //         : null),
                                      ),


                                    ),
                                    isExpanded: task.isExpanded,
                                  )
                                ],
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
                              return Form(
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
                                        ),
                                        validator: (value) =>
                                            (value == null || value.isEmpty)
                                                ? "Please enter a valid"
                                                : null,
                                        // onSaved: (value) => _taskName = value!,
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      TextFormField(
                                        controller: _taskDescriptionController,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter Description',
                                        ),
                                        validator: (String? value) =>
                                            (value == null ||
                                                    value.isEmpty ||
                                                    value.length < 12)
                                                ? 'Please Enter  Valid Desc'
                                                : null,
                                        // onSaved: (value) =>
                                        //     _taskDescription = value!,
                                      ),
                                      GestureDetector(
                                        onTap: () => _selectTime(context),
                                        child: AbsorbPointer(
                                          child: TextFormField(
                                            controller: _timeController,
                                            decoration: InputDecoration(
                                              hintText: 'Select Time',
                                            ),
                                            validator: (value) {
                                              if (_selectedTime == null) {
                                                return 'Please select a time';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Validate will return true if the form is valid, or false if
                                            // the form is invalid.
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // _formKey.currentState!.save();
                                              taskBloc.add(AddTaskEvent(
                                                Task(
                                                    name: _taskController.text,
                                                    time: _timeController.text,
                                                    description: _taskDescriptionController.text),


                                              ));
                                              _formKey.currentState!.reset();
                                              Navigator.pop(context);

                                              // print(email);
                                              // print(passWord);
                                            }
                                          },
                                          child: const Text('Add Task'),
                                        ),
                                      ),
                                    ],
                                  ));
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
