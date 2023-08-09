import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppInfo2 {
  final dynamic brandId;
  final Widget loginPage;
  final Function showAlertDialog;
  final Function showConfirmDialog;

  AppInfo2(
      {required this.brandId,
      required this.showAlertDialog,
      required this.loginPage,
      required this.showConfirmDialog});
}

class AppController2 extends GetxController {
  var appInfo = Rxn<AppInfo2>();
}
