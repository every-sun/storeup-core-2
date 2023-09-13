import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:user_core2/model/auth.dart';

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
}
