import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/model/product_group.dart';
import 'package:user_core2/service/product_group_service.dart';
import 'package:user_core2/util/dialog.dart';

class ProductGroupController2 extends GetxController {
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
      var result = await ProductGroupServices2.getProductGroups(
          Get.find<AppController2>().appInfo.value!.brandId);
      if (result.status) {
        productGroups.value = result.data;
      }
      isLoading.value = false;
    } catch (err) {
      showErrorDialog();
      isLoading.value = false;
      return;
    }
  }
}
