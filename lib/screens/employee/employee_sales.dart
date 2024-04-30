import 'package:flutter/material.dart';

class EmployeeSales extends StatefulWidget {
  const EmployeeSales({super.key});

  @override
  State<EmployeeSales> createState() => _EmployeeSalesState();
}

class _EmployeeSalesState extends State<EmployeeSales> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Employee Sales'
      )
    );
  }
}
