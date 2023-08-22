import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/order.dart';
import 'package:user_core2/service/order_service.dart';
import 'package:user_core2/util/dialog.dart';

class OrderController2 extends GetxController {
  UserController2 userController = Get.put(UserController2());

  var isLoading = false.obs;
  var selectCartSumPrice = 0.obs;
  var paymentMethod = "card".obs;
  var ePayCard = "TOSSPAY".obs;
  var orderType = "S".obs;

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  Future<bool> requestOrder(OrderRequestBody body) async {
    try {
      isLoading.value = true;
      BasicResponse response = await OrderServices2.requestOrder(body);
      isLoading.value = false;
      if (!response.status) {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return false;
    }
  }
}
