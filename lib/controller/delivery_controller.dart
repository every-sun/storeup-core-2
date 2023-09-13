import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/delivery_address.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/delivery_service.dart';
import 'package:user_core2/util/dialog.dart';

class DeliveryController extends GetxController {
  var isLoading = false.obs;
  var userAddress = Rxn<DeliveryAddress>();

  @override
  void onInit() {
    print('delivery controller onInit');
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
      showErrorDialog();
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
        print('isAvailable: ${response.data!.isAvailableRegion}');
      }
      return;
    } catch (err) {
      isLoading.value = false;
      showBasicAlertDialog('배달지를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.');
      return;
    }
  }
}
