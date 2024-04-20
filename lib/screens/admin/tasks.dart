import 'package:employee_management_r/database/database_helper.dart';
import 'package:flutter/material.dart';


class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks when the screen initializes
  }

  void _loadTasks() async {
    List<Map<String, dynamic>> tasks = await DatabaseHelper.instance.getTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _assignTask(int taskId, int employeeId) async {
    // Assign task to employee by updating the task's employee_id
    int result = await DatabaseHelper.instance.updateTaskEmployee(taskId, employeeId);

    if (result != -1) {
      // Task assigned successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task assigned successfully.')),
      );
      _loadTasks(); // Reload tasks list
    } else {
      // Failed to assign task
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to assign task.')),
      );
    }
  }

  void _completeTask(int taskId) async {
    // Complete task by updating the task's status
    int result = await DatabaseHelper.instance.updateTaskStatus(taskId, 'Completed');

    if (result != -1) {
      // Task marked as completed successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task marked as completed.')),
      );
      _loadTasks(); // Reload tasks list
    } else {
      // Failed to mark task as completed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to mark task as completed.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: _tasks.isEmpty
          ? const Center(
        child: Text('No tasks found.'),
      )
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_tasks[index]['task_name']),
            subtitle: Text('Deadline: ${_tasks[index]['deadline']}'),
            trailing: Checkbox(
              value: _tasks[index]['status'] == 'Completed',
              onChanged: (value) {
                if (value == true) {
                  _completeTask(_tasks[index]['id']);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
