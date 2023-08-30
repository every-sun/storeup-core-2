import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/wish_service.dart';
import 'package:user_core2/util/dialog.dart';

class WishController2 extends GetxController {
  var isLoading = false.obs;
  var isExist = false.obs;

  @override
  void onClose() {
    print('wish controller close');
    isExist.value = false;
    isLoading.value = false;
    super.onClose();
  }

  /* 찜하기 추가&제거 */
  Future<bool> toggleWish(productId) async {
    if (Get.find<UserController2>().customer.value == null) {
      showBasicAlertDialog('로그인이 필요한 서비스입니다.');
      return false;
    }
    try {
      BasicResponse response;
      isLoading.value = true;
      if (isExist.value) {
        response = await WishServices2.deleteWish(
            Get.find<UserController2>().customer.value!.id, productId);
      } else {
        response = await WishServices2.storeWish(
            Get.find<UserController2>().customer.value!.id, productId);
      }
      isLoading.value = false;
      if (response.status) {
        isExist.value = !isExist.value;
      } else {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return false;
    }
  }

  /* 상품 상세페이지에서 찜하기 버튼 색깔  */
  Future<void> checkWish(productId) async {
    if (Get.find<UserController2>().customer.value == null) {
      isExist.value = false;
    } else {
      try {
        bool value = await WishServices2.checkWish(
            Get.find<UserController2>().customer.value!.id, productId);
        isExist.value = value;
      } catch (err) {
        isExist.value = false;
      }
    }
  }
}
