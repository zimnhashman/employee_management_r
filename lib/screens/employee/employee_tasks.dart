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
    _loadWorkReport();
  }

  Future<void> _loadWorkReport() async {
    DateTime now = DateTime.now();
    String formattedDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    List<Map<String, dynamic>> sales = await DatabaseHelper.instance.getSalesForDate(formattedDate);
    setState(() {
      _salesList = sales;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales for Today', style: TextStyle(
          color: Colors.white,
        )),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sales for Today (${DateTime.now().toString().substring(0, 10)})',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 4,
                child: ListView.builder(
                  itemCount: _salesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Sales: \$${_salesList[index]['sales']}'),
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
