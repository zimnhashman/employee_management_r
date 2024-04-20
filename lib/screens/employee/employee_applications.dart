import 'package:employee_management_r/database/database_helper.dart';
import 'package:flutter/material.dart';

class OffDaysApplicationScreen extends StatefulWidget {

  final String username;

  const OffDaysApplicationScreen({super.key, required this.username});
  @override
  _OffDaysApplicationScreenState createState() => _OffDaysApplicationScreenState();
}

class _OffDaysApplicationScreenState extends State<OffDaysApplicationScreen> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  void _submitApplication() async {
    Map<String, dynamic> application = {
      'employee_id': 1, // Replace with actual employee ID
      'start_date': _startDateController.text,
      'end_date': _endDateController.text,
      'reason': _reasonController.text,
      'status': 'Pending',
    };

    int result = await DatabaseHelper.instance.insertOffDay(application);

    if (result != -1) {
      // Application added successfully
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Off day application submitted.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.pop(context); // Close the OffDaysApplicationScreen
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Failed to add application
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to submit off day application.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Off Days'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _startDateController,
              decoration: const InputDecoration(labelText: 'Start Date'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _endDateController,
              decoration: const InputDecoration(labelText: 'End Date'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(labelText: 'Reason'),
              maxLines: null,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitApplication,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
