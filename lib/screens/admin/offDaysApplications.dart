import 'package:employee_management_r/database/database_helper.dart';
import 'package:flutter/material.dart';
class AdminOffDaysScreen extends StatefulWidget {
  @override
  _AdminOffDaysScreenState createState() => _AdminOffDaysScreenState();
}

class _AdminOffDaysScreenState extends State<AdminOffDaysScreen> {
  List<Map<String, dynamic>> _pendingApplications = [];

  @override
  void initState() {
    super.initState();
    _loadPendingApplications(); // Load pending off day applications when the screen initializes
  }

  void _loadPendingApplications() async {
    List<Map<String, dynamic>> applications = await DatabaseHelper.instance.getPendingOffDayApplications();
    setState(() {
      _pendingApplications = applications;
    });
  }

  void _acceptApplication(int applicationId) async {
    int result = await DatabaseHelper.instance.updateOffDayStatus(applicationId, 'Approved');

    if (result != -1) {
      // Status updated successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Off day application approved.')),
      );
      _loadPendingApplications(); // Reload pending applications
    } else {
      // Failed to update status
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to approve off day application.')),
      );
    }
  }

  void _rejectApplication(int applicationId) async {
    int result = await DatabaseHelper.instance.updateOffDayStatus(applicationId, 'Rejected');

    if (result != -1) {
      // Status updated successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Off day application rejected.')),
      );
      _loadPendingApplications(); // Reload pending applications
    } else {
      // Failed to update status
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to reject off day application.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Off Day Applications'),
      ),
      body: _pendingApplications.isEmpty
          ? const Center(
        child: Text('No pending applications.'),
      )
          : ListView.builder(
        itemCount: _pendingApplications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Employee ID: ${_pendingApplications[index]['employee_id']}'),
            subtitle: Text('Reason: ${_pendingApplications[index]['reason']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () => _acceptApplication(_pendingApplications[index]['id']),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _rejectApplication(_pendingApplications[index]['id']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
