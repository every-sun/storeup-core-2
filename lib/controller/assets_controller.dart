import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/assets.dart';
import 'package:user_core2/model/brand.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/assets_service.dart';
import 'package:user_core2/util/dialog.dart';

class AssetsController extends GetxController {
  var isLoading = false.obs;
  var availableCoupons = <Coupon>[].obs;
  var allCoupons = <Coupon>[].obs;
  var availablePoints = 0.obs;
  var availableCouponTotal = 0.obs;

  void initStates() {
    isLoading.value = false;
    availableCoupons.clear();
    allCoupons.clear();
    availableCouponTotal.value = 0;
    availablePoints.value = 0;
  }

  Future<void> issueCoupon(couponNo, successMethod) async {
    try {
      isLoading.value = true;
      BasicResponse response = await AssetsServices.issueCoupon(
          Get.find<UserController>().customer.value!.id, couponNo);
      isLoading.value = false;
      if (response.status) {
        successMethod();
        return;
      } else {
        showBasicAlertDialog(response.message);
        return;
      }
    } catch (err) {
      isLoading.value = false;
      showErrorDialog();
      return;
    }
  }

  Future<void> getAvailableCoupons(
      // TODO
      int productSumPrice,
      ShippingFeeResponseData shippingFee) async {
    if (Get.find<UserController>().customer.value == null) return;
    try {
      isLoading.value = true;
      List<Coupon> list = await AssetsServices.getCouponsForOrder(
          Get.find<UserController>().customer.value!.id);
      isLoading.value = false;

      List<Coupon> availableList = [];

      List<Coupon> notAvailableList = [];
      for (var i = 0; i < list.length; i++) {
        if (list[i].conditionType == 'P') {
          // 구매 가격 기준
          if (list[i].availableAmountMin <= productSumPrice) {
            availableList.add(list[i]);
          } else {
            notAvailableList.add(list[i]);
          }
        } else if (list[i].conditionType == 'S') {
          // 무료 배송인 경우에만 가능
          if (shippingFee.conditionType == 'P') {
            if (productSumPrice >= shippingFee.condition) {
              availableList.add(list[i]);
            } else {
              notAvailableList.add(list[i]);
            }
          } else if (shippingFee.conditionType == 'F') {
            availableList.add(list[i]);
          }
        }
      }
      allCoupons.assignAll(availableList);
      allCoupons.addAll(notAvailableList);
      availableCoupons.assignAll(availableList);
      return;
    } catch (err) {
      isLoading.value = false;
      showErrorDialog();
      return;
    }
  }

  Future<void> setAvailablePoint() async {
    if (Get.find<UserController>().customer.value == null) return;
    try {
      isLoading.value = true;
      int response = await AssetsServices.getPointTotal(
          Get.find<UserController>().customer.value!.id);
      availablePoints.value = response;
      isLoading.value = false;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('포인트를 가져오는데 실패했습니다.');
      return;
    }
  }

  Future<void> setCouponTotal() async {
    if (Get.find<UserController>().customer.value == null) return;
    try {
      isLoading.value = true;
      int response = await AssetsServices.getCouponTotal(
          Get.find<UserController>().customer.value!.id);
      availableCouponTotal.value = response;
      isLoading.value = false;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('쿠폰 갯수를 가져오는데 실패했습니다.');
      return;
    }
  }
}
