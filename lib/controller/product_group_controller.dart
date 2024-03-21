import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/model/product_group.dart';
import 'package:user_core2/service/product_group_service.dart';
import 'package:user_core2/util/dialog.dart';

class ProductGroupController extends GetxController {
  var isLoading = false.obs;
  var productGroups = <ProductGroup>[].obs;

  @override
  void onInit() {
    setProductGroups();
    super.onInit();
  }

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  /* 장보기 카테고리 불러오기 */
  Future<void> setProductGroups() async {
    try {
      isLoading.value = true;
      ProductGroupResponse result = await ProductGroupServices.getProductGroups(
          Get.find<AppController>().appInfo.value!.brandId);
      if (result.status) {
        productGroups.value = result.data;
      }
      isLoading.value = false;
    } catch (err) {
      showBasicAlertDialog('카테고리를 불러오지 못했습니다. 잠시 후 다시 시도해주세요.');
      isLoading.value = false;
      return;
    }
  }
}
