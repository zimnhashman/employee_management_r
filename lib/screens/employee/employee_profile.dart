import 'package:flutter/material.dart';

class EmployeeProfilePage extends StatefulWidget {
  final String username;

  const EmployeeProfilePage({super.key, required this.username});
  @override
  State<EmployeeProfilePage> createState() => _EmployeeProfilePageState();
}

class _EmployeeProfilePageState extends State<EmployeeProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Profile'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/profile.jpg'), // Placeholder image
            ),
            SizedBox(height: 16.0),
            Text(
              'John Doe', // Employee's name
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Employee ID: 12345', // Employee's ID
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text('Employment Period'),
              trailing: Text('2 years'), // Hardcoded employment period
            ),
            ListTile(
              title: Text('Off Days Left'),
              trailing: Text('43profile_picture days'), // Hardcoded off days left
            ),
          ],
        ),
      ),
    );
  }
}
