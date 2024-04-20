import 'package:flutter/material.dart';
import 'package:employee_management_r/constants/colors.dart';
import 'package:employee_management_r/widgets/dashboard_tiles.dart';

enum Page { dashboard, manage }

class Dashboard extends StatefulWidget {
  final String name;
  final String userId;

  const Dashboard({super.key, required this.name, required this.userId});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Page _selectedPage = Page.dashboard;
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(

        body: _loadScreen(_selectedPage),
        backgroundColor: backgroundColor,
      ),
    );
  }

  Widget _loadScreen(page) {
    switch (_selectedPage) {
      case Page.dashboard:
        return DashboardTiles(username: widget.name, userId: widget.userId);
      case Page.manage:
        return Container();
      default:
        return Container();
    }
  }
}
