import 'package:employee_management_r/database/database_helper.dart';
import 'package:employee_management_r/screens/admin/add_employee.dart';
import 'package:flutter/material.dart';

class ManageEmployeesScreen extends StatefulWidget {
  @override
  _ManageEmployeesScreenState createState() => _ManageEmployeesScreenState();
}

class _ManageEmployeesScreenState extends State<ManageEmployeesScreen> {
  List<Map<String, dynamic>> _employees = [];

  @override
  void initState() {
    super.initState();
    _loadEmployees(); // Load employees when the screen initializes
  }

  void _loadEmployees() async {
    List<Map<String, dynamic>> employees = await DatabaseHelper.instance.getEmployees();
    setState(() {
      _employees = employees;
    });
  }

  void _deleteEmployee(int employeeId) async {
    int result = await DatabaseHelper.instance.deleteEmployee(employeeId);

    if (result != -1) {
      // Employee deleted successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Employee deleted successfully.')),
      );
      _loadEmployees(); // Reload employees list
    } else {
      // Failed to delete employee
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete employee.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Employees'),
      ),
      body: _employees.isEmpty
          ? const Center(
        child: Text('No employees found.'),
      )
          : ListView.builder(
        itemCount: _employees.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Employee ID: ${_employees[index]['id']}'),
            subtitle: Text('Username: ${_employees[index]['username']}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteEmployee(_employees[index]['id']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddEmployeeScreen to add a new employee
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEmployeeScreen()),
          ).then((value) {
            // Reload employees list after adding a new employee
            _loadEmployees();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
