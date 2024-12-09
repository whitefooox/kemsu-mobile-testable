part of 'bug_report_bloc.dart';

abstract class BugReportEvents extends Equatable {}

class BugReportInitEvent extends BugReportEvents {
  BugReportInitEvent();

  @override
  List<Object?> get props => [];
}

class GetDeviceInfoEvent extends BugReportEvents {
  GetDeviceInfoEvent();

  @override
  List<Object?> get props => [];
}

class SendEvent extends BugReportEvents {
  SendEvent({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class FetchEvent extends BugReportEvents {
  FetchEvent();

  @override
  List<Object?> get props => [];
}
