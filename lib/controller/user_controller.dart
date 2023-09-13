import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:user_core2/model/auth.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/user_service.dart';
import 'package:user_core2/util/dialog.dart';

class UserController extends GetxController {
  var customer = Rxn<Customer>();
  var token = ''.obs;
  var isLoading = false.obs;

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  /* 사용자 정보 삭제 */
  deleteInfo(String appName, bool isLogout) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: '$appName-customer');
    await storage.delete(key: '$appName-token');
    token.value = '';
    customer.value = null;
  }

  Future<void> updateInfo(Map body, key, successMethod) async {
    try {
      isLoading.value = true;
      BasicResponse response = await UserServices.updateInfo(
          body, Get.find<UserController>().customer.value!.id);
      isLoading.value = false;
      if (response.status) {
        await setInfo(key);
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
      return;
    } catch (err) {
      isLoading.value = false;
      showErrorDialog();
      return;
    }
  }

  Future<void> setInfo(
    key,
  ) async {
    if (Get.find<UserController>().customer.value == null) return;
    try {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      CustomerResponse response = await UserServices.getInfo(
          Get.find<UserController>().customer.value!.id);
      if (response.status && response.data != null) {
        customer.value = response.data;
        storage.write(key: key, value: jsonEncode(response.data!.toJson()));
      } else {
        showBasicAlertDialog(response.message);
      }
    } catch (err) {
      showErrorDialog();
      return;
    }
  }

  Future<void> updateAgreementInfo(Map body, successMethod) async {
    try {
      isLoading.value = true;
      BasicResponse response = await UserServices.updateAgreementInfo(
          body, Get.find<UserController>().customer.value!.id);
      isLoading.value = false;
      if (response.status) {
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
      return;
    } catch (err) {
      isLoading.value = false;
      showErrorDialog();
      return;
    }
  }

}
