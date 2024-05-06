import 'package:employee_management_r/database/database_helper.dart';
import 'package:flutter/material.dart';

class WorkReportPage extends StatefulWidget {
  @override
  _WorkReportPageState createState() => _WorkReportPageState();
}

class _WorkReportPageState extends State<WorkReportPage> {
  List<Map<String, dynamic>> _salesList = [];

  @override
  void initState() {
    super.initState();
    _loadSales();
  }

  Future<void> _loadSales() async {
    List<Map<String, dynamic>> sales = await DatabaseHelper.instance
        .getAllSales();
    setState(() {
      _salesList = sales;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // White back button
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Work Report Page', style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sales Today',
              style: TextStyle(fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            Expanded(
              child: Card(
                elevation: 4,
                child: ListView.builder(
                  itemCount: _salesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          'Date: ${_salesList[index]['date']} - Sales: \$${_salesList[index]['sales']}'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
