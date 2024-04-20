import 'package:employee_management_r/constants/colors.dart';
import 'package:employee_management_r/screens/admin/announcements_screen.dart';
import 'package:employee_management_r/screens/admin/manage_employees.dart';
import 'package:employee_management_r/screens/admin/offDaysApplications.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  final String username;
  const AdminDashboard({super.key, required this.username});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  late double width;
  late double height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.purple,
              title: const Text(
                'Dashboard',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [
                            Colors.purple,
                            Colors.pinkAccent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(10),
                  width: width,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome ${widget.username},',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have a nice day!',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Icon(Icons.tag_faces, color: Colors.white)
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        children: [
                          GestureDetector(
                            child: const Card(
                              margin: EdgeInsets.all(10),
                              color: cardColor,
                              elevation: 5.0,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.medical_services_outlined,
                                        size: 50, color: primaryColor),
                                    Text(
                                      'Announcements',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AnnouncementsScreen()))
                            },
                          ),
                          GestureDetector(
                            child: const Card(
                              margin: EdgeInsets.all(10),
                              color: cardColor,
                              elevation: 5.0,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.switch_account,
                                        size: 50, color: primaryColor),
                                    Text(
                                      'Notfications',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AdminOffDaysScreen()))
                            },
                          ),
                          GestureDetector(
                            child: const Card(
                              margin: EdgeInsets.all(10),
                              color: cardColor,
                              elevation: 5.0,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.contact_mail_outlined,
                                        size: 50, color: primaryColor),
                                    Text(
                                      'Manage Employees',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ManageEmployeesScreen()))
                            },
                          ),
                        ]),
                  ),
                ),
              ],
            )));
  }
}
