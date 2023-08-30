import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/order.dart';
import 'package:user_core2/service/order_service.dart';
import 'package:user_core2/util/dialog.dart';

class OrderController2 extends GetxController {
  UserController2 userController = Get.put(UserController2());

  var isLoading = false.obs;
  var paymentMethod = "card".obs;
  var ePayCard = "TOSSPAY".obs;
  var orderType = "S".obs;
  var shippingMessage = ''.obs;

  var startDate = DateTime(DateTime.now().year, DateTime.now().month - 1).obs;
  var endDate = DateTime.now().obs;

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  Future<OrderRequestResponse?> requestOrder(OrderRequestBody body) async {
    try {
      isLoading.value = true;
      OrderRequestResponse response = await OrderServices2.requestOrder(body);
      isLoading.value = false;
      if (!response.status) {
        showBasicAlertDialog(response.message);
      }
      return response;
    } catch (err) {
      print(err);
      showErrorDialog();
      isLoading.value = false;
      return null;
    }
  }
}
