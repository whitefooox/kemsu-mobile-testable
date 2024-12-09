// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      reportId: (json['reportId'] as num?)?.toInt(),
      message: json['message'] as String?,
      messageDate: json['messageDate'] as String?,
      reportStatus: json['reportStatus'] as String?,
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'reportId': instance.reportId,
      'message': instance.message,
      'messageDate': instance.messageDate,
      'reportStatus': instance.reportStatus,
    };
