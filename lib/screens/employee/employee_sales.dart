import 'package:employee_management_r/database/database_helper.dart';
import 'package:flutter/material.dart';

class EmployeeSalesPage extends StatefulWidget {
  @override
  _EmployeeSalesPageState createState() => _EmployeeSalesPageState();
}

class _EmployeeSalesPageState extends State<EmployeeSalesPage> {
  final TextEditingController _salesController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  List<Map<String, dynamic>> _salesList = [];

  @override
  void initState() {
    super.initState();
    _loadSales();
  }

  Future<void> _loadSales() async {
    List<Map<String, dynamic>> sales = await DatabaseHelper.instance.getAllSales();
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
        title: const Text('Sales Dashboard', style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Sales',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                    TextField(
                      controller: _salesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Selected Date: ${_selectedDate.toString()}'),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: const Text('Select Date'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _saveSale,
                      child: const Text('Save Sale'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sales List',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            Expanded(
              child: Card(
                elevation: 4,
                child: ListView.builder(
                  itemCount: _salesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Date: ${_salesList[index]['date']} - Sales: \$${_salesList[index]['sales']}'),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveSale() async {
    String sales = _salesController.text;
    await DatabaseHelper.instance.insertSale({'date': _selectedDate.toString(), 'sales': sales});
    _loadSales(); // Reload sales data after saving
    _salesController.clear(); // Clear the text field after saving
  }
}
