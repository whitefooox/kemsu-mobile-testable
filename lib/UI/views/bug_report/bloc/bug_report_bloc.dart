import 'dart:developer';
import 'dart:io';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kemsu_app/Configurations/navigation.dart';
import 'package:kemsu_app/UI/common_views/snack_bar.dart';
import 'package:kemsu_app/domain/models/report/report_model.dart';
import 'package:kemsu_app/domain/repositories/bug_report/bug_report_repository.dart';

part 'bug_report_events.dart';
part 'bug_report_state.dart';

class BugReportBloc extends Bloc<BugReportEvents, BugReportState> {
  BugReportBloc({required BugReportRepository bugReportRepository, required FlutterSecureStorage storage})
      : _bugReportRepository = bugReportRepository,
        _storage = storage,
        super(const BugReportState()) {
    on<BugReportInitEvent>(_onInit);
    on<GetDeviceInfoEvent>(_onGetDeviceInfo);
    on<SendEvent>(_onSendReport);
    on<FetchEvent>(_onFetchReports);
  }

  final BugReportRepository _bugReportRepository;
  final FlutterSecureStorage _storage;

  Future<void> _onInit(BugReportInitEvent event, Emitter<BugReportState> emit) async {
    log('Bug Report Init Event');

    //AppMetrica init
    AppMetrica.activate(const AppMetricaConfig("21985624-7a51-4a70-8a98-83b918e490d8"));
    AppMetrica.reportEvent('BugReport event');

    //Get Device Info
    add(GetDeviceInfoEvent());
  }

  Future<void> _onGetDeviceInfo(GetDeviceInfoEvent event, Emitter<BugReportState> emit) async {
    log('Get Device Info Event');
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var model = androidInfo.model;
      emit(state.copyWith(deviceInfo: "Android $release (SDK $sdkInt), $model"));
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;
      emit(state.copyWith(deviceInfo: '$systemName $version, $name $model'));
    }
  }

  Future<void> _onSendReport(SendEvent event, Emitter<BugReportState> emit) async {
    log('Send Report Event');

    String? accessToken = await _storage.read(key: "tokenKey");
    bool isTestUser = accessToken == 'accessToken';
    if (state.errorText.isNotEmpty) {
      try {
        if (isTestUser) {
          emit(
            state.copyWith(
              reports: [
                ReportModel(
                  reportId: 0,
                  message: state.errorText,
                  messageDate: "15.06.2024",
                  reportStatus: "Заявка не обработана",
                ),
              ],
            ),
          );

          AppRouting.back();
          showSnackBar(content: "Ваше обращение успешно отправлено (мок).");
        } else {
          try {
            await _bugReportRepository.sendReport(reportText: state.errorText, deviceInfo: state.deviceInfo);
            await _bugReportRepository.fetchReports();
            AppRouting.back();
            showSnackBar(content: "Ваше обращение успешно отправлено.");
          } on DioException catch (error) {
            showSnackBar(content: "Произошла ошибка при отправке обращения. $error");
          }
        }
      } catch (e) {
        showSnackBar(content: "Произошла ошибка при отправке обращения.");
      }
    } else {
      showSnackBar(content: "Заполните все поля обращения!");
    }

    AppMetrica.activate(const AppMetricaConfig("21985624-7a51-4a70-8a98-83b918e490d8"));
    AppMetrica.reportEvent('Send bugreport event');
  }

  Future<void> _onFetchReports(FetchEvent event, Emitter<BugReportState> emit) async {
    log('Fetch Reports Event');
    String? accessToken = await _storage.read(key: "tokenKey");
    bool isTestUser = accessToken == 'accessToken';

    if (isTestUser) {
      emit(
        state.copyWith(
          reports: [
            ReportModel(
              reportId: 0,
              message: "Тестовый отчет",
              messageDate: "15.06.2024",
              reportStatus: "Решено",
            )
          ],
        ),
      );
    } else {
      try {
        final reportsList = await _bugReportRepository.fetchReports();
        emit(state.copyWith(reports: reportsList));
      } on DioException catch (error) {
        showSnackBar(content: "Произошла ошибка при получении обращений. $error");
      }
    }
  }
}
