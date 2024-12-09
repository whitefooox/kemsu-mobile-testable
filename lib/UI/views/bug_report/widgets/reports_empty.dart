import 'package:flutter/material.dart';
import 'package:kemsu_app/Configurations/localizable.dart';

class ReportsEmptyWidget extends StatelessWidget {
  const ReportsEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Localizable.bugReportEmpty,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF757575),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
