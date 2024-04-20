import 'package:employee_management_r/database/database_helper.dart';
import 'package:flutter/material.dart';

class EmployeeNotificationsScreen extends StatefulWidget {

  final String username;

  const EmployeeNotificationsScreen({super.key, required this.username});
  @override
  _EmployeeNotificationsScreenState createState() => _EmployeeNotificationsScreenState();
}

class _EmployeeNotificationsScreenState extends State<EmployeeNotificationsScreen> {
  List<Map<String, dynamic>> _newsList = [];

  @override
  void initState() {
    super.initState();
    _loadNews(); // Load news items when the screen initializes
  }

  void _loadNews() async {
    List<Map<String, dynamic>> news = await DatabaseHelper.instance.getAllNews();
    setState(() {
      _newsList = news;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.username} Notifications'),
      ),
      body: _newsList.isEmpty
          ? Center(
        child: Text('No news available.'),
      )
          : ListView.builder(
        itemCount: _newsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_newsList[index]['message']),
            subtitle: Text(
              'Posted by Admin ${_newsList[index]['admin_id']}',
            ),
            trailing: Text(
              '${_newsList[index]['timestamp']}',
            ),
          );
        },
      ),
    );
  }
}
