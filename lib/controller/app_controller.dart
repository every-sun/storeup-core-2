import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppInfo {
  final dynamic brandId;
  final Widget loginPage;
  final Function showAlertDialog;
  final Function showConfirmDialog;
  AppInfo(
      {required this.brandId,
      required this.showAlertDialog,
      required this.loginPage,
      required this.showConfirmDialog});
}

class AppController extends GetxController {
  var appInfo = Rxn<AppInfo>();
}
