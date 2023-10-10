import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/delivery_address.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/delivery_service.dart';
import 'package:user_core2/util/dialog.dart';

class DeliveryAddressController extends GetxController {
  var isLoading = false.obs;
  var userAddress = Rxn<DeliveryAddress>();

  @override
  void onInit() {
    setUserAddress();
    super.onInit();
  }

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  Future<void> saveDeliveryAddress(
      newAddress, oldAddress, detailAddress, successMethod) async {
    try {
      isLoading.value = true;
      BasicResponse response = await DeliveryServices.saveDeliveryAddress(
          Get.find<UserController>().customer.value!.id,
          newAddress,
          oldAddress,
          detailAddress);
      isLoading.value = false;
      if (response.status) {
        await setUserAddress();
        successMethod();
      } else {
        showBasicAlertDialog(response.message);
      }
      return;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('배달지 설정에 실패하였습니다.');
      return;
    }
  }

  Future<void> setUserAddress() async {
    try {
      if (Get.find<UserController>().customer.value == null) return;
      isLoading.value = true;
      DeliveryAddressResponse response =
          await DeliveryServices.getDeliveryAddressByCustomerId(
              Get.find<UserController>().customer.value!.id);
      isLoading.value = false;
      if (response.status) {
        userAddress.value = response.data;
      }
      return;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('배달지를 조회하는데 실패하였습니다.');
      return;
    }
  }
}
