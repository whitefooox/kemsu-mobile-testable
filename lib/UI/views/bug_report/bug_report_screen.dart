import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemsu_app/Configurations/localizable.dart';
import 'package:kemsu_app/UI/common_views/loader.dart';
import 'package:kemsu_app/UI/common_widgets.dart';
import 'package:kemsu_app/UI/views/bug_report/bloc/bug_report_bloc.dart';
import 'package:kemsu_app/UI/views/bug_report/widgets/new_message_dialog.dart';
import 'package:kemsu_app/UI/views/bug_report/widgets/reports_empty.dart';
import 'package:kemsu_app/UI/views/bug_report/widgets/reports_error.dart';
import 'package:kemsu_app/UI/views/bug_report/widgets/reports_list.dart';

class BugReportScreen extends StatefulWidget {
  const BugReportScreen({super.key});

  @override
  State<BugReportScreen> createState() => _BugReportScreenState();
}

class _BugReportScreenState extends State<BugReportScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BugReportBloc, BugReportState>(
      builder: (context, state) {
        switch (state.status) {
          case BugReportStatus.loading:
            return Scaffold(
              appBar: customAppBar(context, Localizable.bugReportTitle),
              body: LoaderWidget(),
            );
          case BugReportStatus.active:
            return Scaffold(
              appBar: customAppBar(context, Localizable.bugReportTitle),
              body: ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  const SizedBox(
                    height: 34,
                  ),
                  ReportsErrorWidget(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(Localizable.bugReportWarningMessage, style: const TextStyle(color: Colors.red)),
                  ),
                  state.reports.isEmpty ? ReportsEmptyWidget() : ReportsListWidget(reports: state.reports),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blue,
                child: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  showDialog(context: context, builder: (_) => NewMessageDialog());
                },
              ),
            );
          case BugReportStatus.error:
            return Scaffold(
              appBar: customAppBar(context, Localizable.bugReportTitle),
              body: ReportsErrorWidget(),
            );
        }
      },
    );
  }
}
