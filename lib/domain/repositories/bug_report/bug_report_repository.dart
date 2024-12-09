import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kemsu_app/Configurations/config.dart';
import 'package:kemsu_app/UI/common_views/snack_bar.dart';
import 'package:kemsu_app/domain/dio_wrapper/dio_client.dart';
import 'package:kemsu_app/domain/models/report/report_model.dart';

abstract class BugReportRepository {
  Future<void> sendReport({required String reportText, required String deviceInfo});

  Future<List<ReportModel>> fetchReports();
}

class BugReportRepositoryImpl implements BugReportRepository {
  BugReportRepositoryImpl({required this.dio, required this.storage});

  final DioClient dio;
  final FlutterSecureStorage storage;

  @override
  Future<void> sendReport({required String reportText, required String deviceInfo}) async {
    final String? accessToken = await storage.read(key: "tokenKey");
    final data = {"message": reportText, "deviceInfo": deviceInfo};
    await dio.post(
      Config.addReport,
      options: Options(headers: {'x-access-token': accessToken}),
      data: data,
    );
  }

  @override
  Future<List<ReportModel>> fetchReports() async {
    final String? accessToken = await storage.read(key: "tokenKey");
    final response = await dio.get(
      Config.bugReport,
      options: Options(headers: {'x-access-token': accessToken}),
    );

    return response.data["result"].map<ReportModel>((json) => ReportModel.fromJson(json)).toList();
  }
}
