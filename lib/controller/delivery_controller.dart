import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/model/delivery_product.dart';
import 'package:user_core2/model/review.dart';
import 'package:user_core2/service/delivery_service.dart';
import 'package:user_core2/service/review_service.dart';

class DeliveryController extends GetxController {
  var isLoading = false.obs;
  var categoryMenu = ''.obs;
  var deliveryDetail = {}
      .obs; // {'menu': [DeliveryProductsByCategoryData, ...], 'reviews': [], 'review_total': 0, 'menu_keys': {'category.name': 'GlobalKey', 'category.name': 'GlobalKey'}, 'category_keys': {'category.name': 'GlobalKey', 'category.name': 'GlobalKey'}}
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
    isLoading.value = true;
    DeliveryProductsByCategoryResponse response =
        await DeliveryServices.getDeliveryProductsByStore(
            Get.find<AppController>().appInfo.value!.brandId, tenantId);
    ModelReviewResponse reviewResponse =
        await ReviewServices2.getReviewsByStore(
            Get.find<AppController>().appInfo.value!.brandId, tenantId, 1);
    if (response.status && response.data != null) {
      deliveryDetail['menus'] = response.data;
      if (response.data!.isNotEmpty) {
        categoryMenu.value = response.data![0].name;
      }
    }
    deliveryDetail['menu_keys'] = {};
    deliveryDetail['category_keys'] = {};
    for (var i = 0; i < deliveryDetail['menus'].length; i++) {
      deliveryDetail['menu_keys'][deliveryDetail['menus'][i].name] =
          GlobalKey();
      deliveryDetail['category_keys'][deliveryDetail['menus'][i].name] =
          GlobalKey();
    }
    if (reviewResponse.status && reviewResponse.data != null) {
      deliveryDetail['reviews'] = reviewResponse.data!.data;
      deliveryDetail['review_total'] = reviewResponse.data!.total;
    }
    isLoading.value = false;
    deliveryDetail.refresh();
    return;
  }
}
