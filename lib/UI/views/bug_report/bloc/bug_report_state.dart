part of 'bug_report_bloc.dart';

enum BugReportStatus { loading, active, error }

class BugReportState extends Equatable {
  const BugReportState({
    this.errorText = '',
    this.deviceInfo = '',
    this.status = BugReportStatus.loading,
    this.reports = const [],
  });

  final String errorText;
  final String deviceInfo;
  final BugReportStatus status;
  final List<ReportModel> reports;

  BugReportState copyWith({
    String? errorText,
    String? deviceInfo,
    BugReportStatus? status,
    List<ReportModel>? reports,
  }) {
    return BugReportState(
      errorText: errorText ?? this.errorText,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      status: status ?? this.status,
      reports: reports ?? this.reports,
    );
  }

  @override
  List<Object?> get props => [
        errorText,
        deviceInfo,
        status,
        reports,
      ];
}
