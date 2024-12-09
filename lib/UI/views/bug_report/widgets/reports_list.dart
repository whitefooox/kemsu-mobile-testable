import 'package:flutter/material.dart';
import 'package:kemsu_app/Configurations/localizable.dart';
import 'package:kemsu_app/domain/models/report/report_model.dart';

class ReportsListWidget extends StatelessWidget {
  const ReportsListWidget({
    super.key,
    required this.reports,
  });

  final List<ReportModel> reports;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final reportList = reports[index].reportStatus;
          return ExpansionTile(
            title: Text(reports[index].message.toString()),
            subtitle: Text(reportList ?? Localizable.bugReportNotProcessed,
                style: TextStyle(
                    color: reportList == "Решено" ? Colors.green : Colors.red)),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColorDark),
                        children: <TextSpan>[
                          TextSpan(text: Localizable.bugReportDate),
                          TextSpan(
                            text: reports[index].messageDate.toString(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
