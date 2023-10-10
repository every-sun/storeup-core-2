import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:user_core2/model/auth.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/user_service.dart';
import 'package:user_core2/util/dialog.dart';

class UserController extends GetxController {
  var customer = Rxn<Customer>();
  var isLoading = false.obs;

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  /* 사용자 정보 삭제 */
  deleteCustomer(String customerKey, bool isLogout) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: customerKey);
    customer.value = null;
  }

  Future<void> updateCustomer(Map body, key, successMethod) async {
    try {
      isLoading.value = true;
      BasicResponse response = await UserServices.updateCustomer(
          body, Get.find<UserController>().customer.value!.id);
      isLoading.value = false;
      if (response.status) {
        await setCustomer(key, Get.find<UserController>().customer.value!.id);
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
      return;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('사용자 정보 업데이트에 실패하였습니다.');
      return;
    }
  }

  Future<void> setCustomer(
    key,
    customerId,
  ) async {
    try {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      CustomerResponse response = await UserServices.getCustomer(customerId);
      if (response.status && response.data != null) {
        customer.value = response.data;
        storage.write(key: key, value: jsonEncode(response.data!.toJson()));
      } else {
        showBasicAlertDialog(response.message);
      }
    } catch (err) {
      showBasicAlertDialog('사용자 정보 업데이트에 실패하였습니다.');
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
      showBasicAlertDialog('정보를 업데이트하는데 실패하였습니다.');
      return;
    }
  }

  Future<void> updateRefundAccount(Map body, key, successMethod) async {
    try {
      isLoading.value = true;
      BasicResponse response = await UserServices.updateRefundAccount(
          body, Get.find<UserController>().customer.value!.id);
      isLoading.value = false;
      if (response.status) {
        await setCustomer(key, Get.find<UserController>().customer.value!.id);
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
      return;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('환불계좌 정보 업데이트에 실패하였습니다.');
      return;
    }
  }

  Future<void> resetRefundAccount(key, successMethod) async {
    try {
      isLoading.value = true;
      BasicResponse response = await UserServices.resetRefundAccount(
          Get.find<UserController>().customer.value!.id);
      isLoading.value = false;
      if (response.status) {
        await setCustomer(key, Get.find<UserController>().customer.value!.id);
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
      return;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('환불계좌 정보 업데이트에 실패하였습니다.');
      return;
    }
  }
}
