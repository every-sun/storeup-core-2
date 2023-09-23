import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/assets.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/order.dart';
import 'package:user_core2/service/order_service.dart';
import 'package:user_core2/util/dialog.dart';

class OrderController extends GetxController {
  UserController userController = Get.put(UserController());

  var isLoading = false.obs;
  var paymentMethod = "card".obs;
  var ePayCard = "TOSSPAY".obs;
  var orderType = "S".obs;
  var shippingMessage = ''.obs;
  var coupon = Rxn<Coupon>();
  var point = 0.obs;

  var startDate = DateTime(DateTime.now().year, DateTime.now().month - 1).obs;
  var endDate = DateTime.now().obs;

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  void initStates() {
    isLoading.value = false;
    point.value = 0;
    paymentMethod.value = "card";
    ePayCard.value = "TOSSPAY";
    shippingMessage.value = '';
    orderType.value = 'S';
    coupon.value = null;
  }

  int getCouponDiscountAmount(int selectCartSumPrice) {
    // TODO
    if (coupon.value == null) return 0;
    var couponDiscountAmount = 0;
    if (coupon.value!.type == 'F') {
      couponDiscountAmount = coupon.value!.discountAmount > selectCartSumPrice
          ? selectCartSumPrice
          : coupon.value!.discountAmount;
    } else if (coupon.value!.type == 'P') {
      if (coupon.value!.availableAmountMax <
          (selectCartSumPrice * (coupon.value!.discountPercentage / 100))
              .toInt()) {
        couponDiscountAmount = coupon.value!.availableAmountMax;
      } else {
        couponDiscountAmount =
            (selectCartSumPrice * (coupon.value!.discountPercentage / 100))
                .toInt();
      }
    }
    return couponDiscountAmount;
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
      showErrorDialog();
      isLoading.value = false;
      return null;
    }
  }

  Future<void> requestOrderConfirm(itemId, successMethod) async {
    try {
      isLoading.value = true;
      BasicResponse response = await OrderServices2.requestOrderConfirm(
          Get.find<UserController>().customer.value!.id, itemId);
      isLoading.value = false;
      if (response.status) {
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
      return;
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return;
    }
  }
}
