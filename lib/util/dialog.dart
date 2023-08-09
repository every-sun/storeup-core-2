import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';

void showErrorDialog() {
  Get.find<AppController2>()
      .appInfo
      .value!
      .showAlertDialog('문제가 발생하였습니다. 잠시 후 다시 시도해주세요.', null);
}

void showBasicAlertDialog(title) {
  Get.find<AppController2>().appInfo.value!.showAlertDialog(title, null);
}

void showConfirmDialog(title, method) {
  Get.find<AppController2>().appInfo.value!.showConfirmDialog(title, method);
}
