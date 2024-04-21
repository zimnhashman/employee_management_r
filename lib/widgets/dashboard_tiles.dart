import 'package:employee_management_r/screens/admin/announcements_screen.dart';
import 'package:employee_management_r/screens/admin/tasks.dart';
import 'package:employee_management_r/screens/employee/employee_applications.dart';
import 'package:employee_management_r/screens/employee/employee_profile.dart';
import 'package:flutter/material.dart';
import 'package:employee_management_r/constants/colors.dart';



class DashboardTiles extends StatefulWidget {
  final String username;
  final String userId;
  const DashboardTiles({Key? key, required this.username, required this.userId}) : super(key: key);



  @override
  _DashboardTilesState createState() => _DashboardTilesState();
}


class _DashboardTilesState extends State<DashboardTiles> {

  late double width;
  late double height;



  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
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
        const SizedBox(height: 25),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView(
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                 OffDaysApplicationScreen(username: widget.username)));
                  },
                  child: const Card(
                    margin: EdgeInsets.all(10),
                    color: cardColor,
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.calendar_today,
                              size: 50, color: primaryColor),
                          Text(
                            'Off-Day Applications',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                              OffDaysApplicationScreen(username: widget.username,)));
                  },
                  child: const Card(
                    margin: EdgeInsets.all(10),
                    color: cardColor,
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.science_outlined,
                              size: 50, color: primaryColor),
                          Text(
                            'Tasks',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                AnnouncementsScreen()));
                  },
                  child: const Card(
                    margin: EdgeInsets.all(10),
                    color: cardColor,
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.science_outlined,
                              size: 50, color: primaryColor),
                          Text(
                            'Tasks',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>  EmployeeProfilePage(username: widget.username,)));
                  },
                  child: const Card(
                    margin: EdgeInsets.all(10),
                    color: cardColor,
                    elevation: 5.0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.add_alarm_outlined,
                              size: 50, color: primaryColor),
                          Text(
                            'Employee Profile',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
