import 'package:flutter/material.dart';

class DailyWorkReport extends StatefulWidget {
  const DailyWorkReport({super.key});

  @override
  State<DailyWorkReport> createState() => _DailyWorkReportState();
}

class _DailyWorkReportState extends State<DailyWorkReport> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: (
      Text('Daily Work Report')
      ),
    );
  }
}
