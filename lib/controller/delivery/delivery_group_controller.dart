import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/model/delivery_group.dart';
import 'package:user_core2/service/delivery_service.dart';

class DeliveryGroupController extends GetxController {
  var isLoading = false.obs;
  var deliveryGroups = <DeliveryGroup>[].obs;

  @override
  void onInit() {
    print('DeliveryGroupController onInit');
    setDeliveryGroups();
    super.onInit();
  }

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  Future<void> setDeliveryGroups() async {
    isLoading.value = true;
    DeliveryGroupResponse responses = await DeliveryServices.getDeliveryGroups(
        Get.find<AppController>().appInfo.value!.brandId);
    if (responses.status) {
      deliveryGroups.value = responses.data;
    }
    isLoading.value = false;
  }
}
