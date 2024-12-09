import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  int? reportId;
  String? message;
  String? messageDate;
  String? reportStatus;

  ReportModel({this.reportId, this.message, this.messageDate, this.reportStatus});

  factory ReportModel.fromJson(Map<String, dynamic> json) => _$ReportModelFromJson(json);
}
