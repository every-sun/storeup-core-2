import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/controller/cart_controller.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/assets.dart';
import 'package:user_core2/model/auth.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/order.dart';
import 'package:user_core2/page/toss_payments_view.dart';
import 'package:user_core2/service/order_service.dart';
import 'package:user_core2/util/dialog.dart';

class OrderController extends GetxController {
  UserController userController = Get.put(UserController());

  var isLoading = false.obs;
  var paymentMethod = "card".obs;
  var ePayCard = "TOSSPAY".obs;
  // var orderType = "S".obs;
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
    coupon.value = null;
  }

  int getCouponDiscountAmount(int selectCartSumPrice) {
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
      OrderRequestResponse response = await OrderServices.requestOrder(body);
      isLoading.value = false;
      if (!response.status) {
        showBasicAlertDialog(response.message);
      }
      return response;
    } catch (err) {
      showBasicAlertDialog('주문에 실패하였습니다.');
      isLoading.value = false;
      return null;
    }
  }

  Future<void> requestOrderConfirm(itemId, successMethod) async {
    try {
      isLoading.value = true;
      BasicResponse response = await OrderServices.requestOrderConfirm(
          Get.find<UserController>().customer.value!.id, itemId);
      isLoading.value = false;
      if (response.status) {
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
      return;
    } catch (err) {
      showBasicAlertDialog('주문 확정에 실패하였습니다.');
      isLoading.value = false;
      return;
    }
  }

  Future<void> sendOrderRequest(
      dynamic orderNo,
      OrderController orderController,
      CartController cartController,
      int orderShippingFee,
      dynamic addressId,
      dynamic shippingFeeSettingId,
      String? contact,
      Map orderRequest,
      detailAddress,
      String? deliveryContact,
      dynamic tenantId,
      String orderType,
      Function successMethod) async {
    Customer customer = Get.find<UserController>().customer.value!;
    OrderRequestResponse? response = await requestOrder(
      OrderRequestBody(
          data: OrderRequestBodyData(
            brandId: Get.find<AppController>().appInfo.value!.brandId,
            orderNo: orderNo,
            orderType: orderType == 'O' ? 'S' : orderType,
            orderMethod: 'app',
            orderShippingFee: orderShippingFee,
            orderPriceAmount: cartController.selectedCartsSumPrice.value,
            isUseDiscountCoupon: coupon.value != null,
            orderDiscountAmount: getCouponDiscountAmount(
                    cartController.selectedCartsSumPrice.value) +
                point.value,
            orderCouponDiscountAmount: getCouponDiscountAmount(
                cartController.selectedCartsSumPrice.value),
            orderCustomDiscountAmount: 0,
            orderAdditionalPaymentAmount: point.value,
            orderPaymentAmount:
                cartController.selectedCartsSumPrice.value + orderShippingFee,
            isOnline: true,
            orderRequest: orderRequest,
            detailAddress: detailAddress,
            deliveryContact: deliveryContact ?? customer.contact,
          ),
          addressId: addressId,
          shippingFeeSettingId: shippingFeeSettingId,
          customer: Customer(
              email: customer.email,
              name: customer.name,
              contact: contact ?? customer.contact,
              id: customer.id),
          tenantId: tenantId,
          items: cartController.selectedCarts
              .map((element) => OrderRequestItem(
                  productId: element.product.id,
                  quantity: element.quantity,
                  options: element.options))
              .toList()),
    );
    if (response != null && response.status && response.data != null) {
      Get.to(() => TossPaymentsView(
          controller: orderController,
          amount: response.data!['order_payment_amount'] as int,
          orderNo: response.data!['order_no'],
          orderName: response.data!['data']['order_name'],
          paymentMethod: orderController.paymentMethod.value,
          successMethod: () {
            successMethod(orderController.paymentMethod.value == 'iCash'
                ? response.data!['id']
                : null);
          },
          flowMode: 'DIRECT'));
    }
  }
}
