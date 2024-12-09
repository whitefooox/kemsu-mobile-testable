import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void showSnackBar({required String content}) {
  final scaffold = scaffoldMessengerKey.currentState;
  scaffold?.hideCurrentSnackBar();
  scaffold?.showSnackBar(
    SnackBar(content: Text(content), duration: const Duration(seconds: 5), showCloseIcon: true, closeIconColor: Colors.white),
  );
}
