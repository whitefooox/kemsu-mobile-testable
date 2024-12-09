import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemsu_app/Configurations/localizable.dart';
import 'package:kemsu_app/UI/views/bug_report/bloc/bug_report_bloc.dart';

class NewMessageDialog extends StatelessWidget {
  const NewMessageDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return AlertDialog(
      title: Text(Localizable.bugReportCreate),
      backgroundColor: Theme.of(context).primaryColor,
      content: TextField(
        cursorColor: Colors.blue,
        controller: controller,
        decoration: InputDecoration(
          hintText: Localizable.bugReportEnterMessage,
        ),
        maxLines: null,
      ),
      actions: [
        TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue, // Text Color
            ),
            onPressed: () => context.read<BugReportBloc>().add(SendEvent(message: controller.text)),
            child: Text(Localizable.bugReportSend))
      ],
    );
  }
}
