import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/model/delivery_product.dart';
import 'package:user_core2/model/review.dart';
import 'package:user_core2/service/delivery_service.dart';
import 'package:user_core2/service/review_service.dart';
import 'package:user_core2/util/dialog.dart';

class DeliveryController extends GetxController {
  var isLoading = false.obs;
  var categoryMenu = ''.obs;
  var deliveryDetail = {}.obs;
  var currentTab = '메뉴'.obs;

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  void initState() {
    currentTab.value = '메뉴';
    deliveryDetail.value = {};
    isLoading.value = false;
    categoryMenu.value = '';
  }

  Future<void> getDetail(tenantId) async {
    try {
      DeliveryProductsByCategoryResponse response =
          await DeliveryServices.getDeliveryProductsByStore(
              Get.find<AppController>().appInfo.value!.brandId, tenantId);
      ModelReviewResponse reviewResponse =
          await ReviewServices2.getReviewsByStore(
              Get.find<AppController>().appInfo.value!.brandId, tenantId, 1);
      if (response.status && response.data != null) {
        deliveryDetail['menus'] = response.data;
        categoryMenu.value = response.data![0].name;
      }
      if (reviewResponse.status && reviewResponse.data != null) {
        deliveryDetail['reviews'] = reviewResponse.data!.data;
        deliveryDetail['review_total'] = reviewResponse.data!.total;
      }
      deliveryDetail.refresh();
      print(deliveryDetail['reviews']);
      return;
    } catch (err) {
      print(err);
      showBasicAlertDialog('데이터를 가져오지 못했습니다.');
      return;
    }
  }
}
