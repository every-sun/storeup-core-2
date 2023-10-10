import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';

void showBasicAlertDialog(title) {
  Get.find<AppController>().appInfo.value!.showAlertDialog(title, null);
}

void showConfirmDialog(title, method) {
  Get.find<AppController>().appInfo.value!.showConfirmDialog(title, method);
}
