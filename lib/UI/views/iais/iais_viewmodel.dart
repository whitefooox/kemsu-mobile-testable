import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stacked/stacked.dart';

import 'package:http/http.dart' as http;
import '../../../API/config.dart';
import '../iais/iais_view.dart';
import '../iais/iais_model.dart';
import 'dart:convert';

class IaisViewModel extends BaseViewModel {
  IaisViewModel(BuildContext context);
  final storage = const FlutterSecureStorage();

  List<CourseIais> Course = [];

  String DISC_NAME = '';
  String DISC_REP = '';
  String DISC_HOURS = '';
  String FIO = '';
  String DISC_FIRST_DATE = '';
  String DISC_LAST_DATE = '';
  String DISC_MARK = '';

  int selectedIndex = 2;

  List<CourseIais> parseCourseList(List response) {
    return response
        .map<CourseIais>((json) => CourseIais.fromJson(json))
        .toList();
  }

  Future onReady() async {
    String? token = await storage.read(key: "tokenKey");
    var dio = Dio();

    var response = await http.get(Uri.parse(
        '${Config.studCourseList}'), headers: {"x-access-token": token!,},);
/*
    final response = await dio
        .get(Config.studCourseList, options: Options(

    ),);*/

    print(response.body);
    Course =
        parseCourseList(json.decode(response.body)['studentCourseList']);
    print(Course);

    notifyListeners();
  }
}