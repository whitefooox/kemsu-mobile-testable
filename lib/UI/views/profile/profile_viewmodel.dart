import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stacked/stacked.dart';
import '../../../API/config.dart';
import '../auth/auth_view.dart';
import '../iais/iais_view.dart';
import '../debts/debts_view.dart';
import '../checkList/checkList_view.dart';
import 'package:intl/intl.dart';

class EnumUserType {
  static String get student => "обучающийся";
  static String get employee => "сотрудник";
}

class ProfileViewModel extends BaseViewModel {
  ProfileViewModel(BuildContext context);

  int selectedIndex = 1;

  void onTapBottomBar(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  final storage = const FlutterSecureStorage();

  String firstName = '';
  String lastName = '';
  String middleName = '';
  String email = '';
  String? phone = '';
  String group = '';
  String speciality = '';
  String faculty = '';
  String course = '';
  String qualification = '';
  String learnForm = '';
  String statusSTR = '';
  String finForm = '';
  String startYear = '';
  String debtData = '';
  String userType = '';
  int? userTypeInt;
  String jobTitle = '';
  String department = '';
  String fio = '';
  File? imageFile;
  String? img64;

  String? avatar;

  prolongToken() async {
    var dio = Dio();

    String? token = await storage.read(key: 'tokenKey');
    final responseProlongToken = await dio
        .post(Config.proLongToken, queryParameters: {"accessToken": token});
    var newToken = responseProlongToken.data['accessToken'];
    await storage.write(key: "tokenKey", value: newToken);
  }

  Future onReady(BuildContext context) async {
    readImage();
    String? token = await storage.read(key: "tokenKey");
    String? login = await storage.read(key: "login");
    String? password = await storage.read(key: "password");
    String? userTypeTemp = await storage.read(key: "userType");
    var dio = Dio();
    final responseProlongToken = await dio
        .post(Config.proLongToken, queryParameters: {"accessToken": token});
    token = responseProlongToken.data['accessToken'];
    await storage.write(key: "tokenKey", value: token);
    final responseAuth = await dio
        .post(Config.apiHost, data: {"login": login, "password": password});

    var userData = responseAuth.data['userInfo'];
    userType = userData["userType"];
    email = userData["email"];
    phone = userData["phone"];
    print(userData);
    if (userType == EnumUserType.student) {
      firstName = userData["firstName"];
      lastName = userData["lastName"];
      middleName = userData["middleName"];
      final responseStudent = await dio
          .get(Config.studCardHost, queryParameters: {"accessToken": token});

      var studentCard = responseStudent.data[0];
      group = studentCard["GROUP_NAME"];
      speciality = studentCard["SPECIALITY"];
      faculty = studentCard["FACULTY"];
      qualification = studentCard["QUALIFICATION"];
      learnForm = studentCard["LEARN_FORM"];
      statusSTR = studentCard["STATUS_STR"];
      finForm = studentCard["FINFORM"];

      await storage.write(key: "firstName", value: firstName);
      await storage.write(key: "lastName", value: lastName);
      await storage.write(key: "middleName", value: middleName);
      await storage.write(key: "group", value: group);

      final responseMoneyDebt = await dio
          .get(Config.studMoneyDebt, queryParameters: {"accessToken": token});
      var moneyDebt = responseMoneyDebt.data["debtInfo"];
      if (moneyDebt["DEBT_AMOUNT"] == null) {
        debtData = "Отсутствует";
      } else {
        debtData = moneyDebt["DEBT_AMOUNT"].toString() +
            " (на дату: " +
            moneyDebt["DEBT_DATE"] +
            ")";
      }
    } else if (userType == EnumUserType.employee) {
      final responseEmployee = await dio
          .get(Config.empCardHost, queryParameters: {"accessToken": token});

      var employeeCard = responseEmployee.data["empList"][0];
      firstName = employeeCard["FIRST_NAME"];
      lastName = employeeCard["LAST_NAME"];
      middleName = employeeCard["MIDDLE_NAME"];
      jobTitle = employeeCard["POST_NAME"];
      department = employeeCard["DEP"];

      await storage.write(key: "firstName", value: firstName);
      await storage.write(key: "lastName", value: lastName);
      await storage.write(key: "middleName", value: middleName);
      await storage.write(key: "jobTitle", value: jobTitle);
      await storage.write(key: "department", value: department);
    }
    fio = ('$lastName $firstName $middleName');

    await storage.write(key: "fio", value: fio);
    await storage.write(key: "email", value: phone);
    await storage.write(key: "phone", value: phone);

    final now = DateTime.now();
    final newYearDate = DateTime(now.year, DateTime.january, 3).toString().split(' ');
    final currentDate = now.toString().split(' ');
    if (currentDate[0] == newYearDate[0]) {
      _showAlertDialog(context);
    }
    notifyListeners();
  }

  readImage() async {
    avatar = await storage.read(key: 'avatar');
    final decodedBytes = base64Decode(avatar!);

    notifyListeners();
  }

  void saveImage(image) async {
    // await storage.write(key: "avatar", value: '$image');
    //avatar = await storage.read(key: 'avatar');
    //final File newImage = await image.copy('images/avatar.png');
    //image = avatar;
    //print('Image: $image, Save Image: $avatar');
    Uint8List imageBytes = await image!.readAsBytes();
    String _base64String = base64.encode(imageBytes);
    print(_base64String);
    await storage.write(key: "avatar", value: _base64String);
    //print(img64);
    notifyListeners();
  }

  void exitButton(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AuthView()));
    notifyListeners();
  }

  void iaisButton(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const IaisView()));
    notifyListeners();
  }

  void debtsButton(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const DebtsView()));
    notifyListeners();
  }

  void checklistButton(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CheckListView()));
    notifyListeners();
  }

  _showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: const Text("Спасибо"),
      onPressed: () { Navigator.pop(context); },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("С новым годом!"),
      content: const Text("Наша команда разработчиков желает вам крепкого здоровья, удачи, благополучия, добра, радости, любви, счастья, хорошего настроения, улыбок, ярких впечатлений. Пусть тепло и уют всегда наполняют ваш дом, пусть солнечный свет согревает в любую погоду, а желания исполняются при одной мысли о них."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}