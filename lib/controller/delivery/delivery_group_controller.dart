import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/model/delivery_group.dart';
import 'package:user_core2/service/delivery_service.dart';
import 'package:user_core2/util/dialog.dart';

class DeliveryGroupController extends GetxController {
  var isLoading = false.obs;
  var deliveryGroups = <DeliveryGroup>[].obs;

  @override
  void onInit() {
    setDeliveryGroups();
    super.onInit();
  }

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  Future<void> setDeliveryGroups() async {
    try {
      isLoading.value = true;
      DeliveryGroupResponse responses =
          await DeliveryServices.getDeliveryGroups(
              Get.find<AppController>().appInfo.value!.brandId);
      if (responses.status) {
        deliveryGroups.value = responses.data;
      }
      isLoading.value = false;
    } catch (err) {
      showBasicAlertDialog('카테고리를 불러오지 못했습니다. 잠시 후 다시 시도해주세요.');
      isLoading.value = false;
      return;
    }
  }
}
