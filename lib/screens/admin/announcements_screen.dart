import 'package:employee_management_r/database/database_helper.dart';
import 'package:flutter/material.dart';


class AnnouncementsScreen extends StatefulWidget {
  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  TextEditingController _newsController = TextEditingController();
  List<Map<String, dynamic>> _newsList = [];

  @override
  void initState() {
    super.initState();
    _loadNews(); // Load existing news items when the screen initializes
  }

  void _loadNews() async {
    List<Map<String, dynamic>> news = await DatabaseHelper.instance.getAllNews();
    setState(() {
      _newsList = news;
    });
  }

  void _addNews() async {
    String message = _newsController.text.trim();
    if (message.isNotEmpty) {
      Map<String, dynamic> news = {
        'admin_id': 1, // Assuming admin ID 1 for the current user
        'message': message,
      };
      int id = await DatabaseHelper.instance.insertNews(news);
      if (id != -1) {
        // Success message or update news list
        _loadNews(); // Reload news list after adding news
        _clearTextField();
      } else {
        // Error message
      }
    } else {
      // Show input validation error
    }
  }

  void _editNews(int id) async {
    // Implement editing functionality here
  }

  void _deleteNews(int id) async {
    int rowsAffected = await DatabaseHelper.instance.deleteNews(id);
    if (rowsAffected > 0) {
      // Success message or update news list
      _loadNews(); // Reload news list after deleting news
    } else {
      // Error message
    }
  }

  void _clearTextField() {
    _newsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _newsController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Enter News Message',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addNews,
              child: const Text('Add News'),
            ),
            const SizedBox(height: 16.0),
            // News list widget
            Expanded(
              child: ListView.builder(
                itemCount: _newsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_newsList[index]['message']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editNews(_newsList[index]['id']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteNews(_newsList[index]['id']),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
