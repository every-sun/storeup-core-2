import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/model/delivery_product.dart';
import 'package:user_core2/model/review.dart';
import 'package:user_core2/service/delivery_service.dart';
import 'package:user_core2/service/review_service.dart';

class DeliveryController extends GetxController {
  var isLoading = false.obs;
  var deliveryDetail = {}
      .obs; // {'menu': [DeliveryProductsByCategoryData, ...], 'reviews': [], 'review_total': 0, }
  var currentTab = '메뉴'.obs;

  @override
  void onClose() {
    initState();
    super.onClose();
  }

  void initState() {
    currentTab.value = '메뉴';
    deliveryDetail.value = {};
    isLoading.value = false;
  }

  Future<void> getDetail(tenantId) async {
    isLoading.value = true;
    DeliveryProductsByCategoryResponse response =
        await DeliveryServices.getDeliveryProductsByStore(
            Get.find<AppController>().appInfo.value!.brandId, tenantId);
    ModelReviewResponse reviewResponse =
        await ReviewServices2.getReviewsByStore(
            Get.find<AppController>().appInfo.value!.brandId, tenantId, 1);
    deliveryDetail['menus'] = [];
    if (response.status && response.data != null && response.data!.isNotEmpty) {
      deliveryDetail['menus'] = response.data;
    }

    if (reviewResponse.status && reviewResponse.data != null) {
      deliveryDetail['reviews'] = reviewResponse.data!.data;
      deliveryDetail['review_total'] = reviewResponse.data!.total;
    }
    isLoading.value = false;
    deliveryDetail.refresh();

    return;
  }

  Map getCategoryAndMenuGlobalKeys() {
    Map result = {'category': {}, 'menu': {}};
    if(deliveryDetail['menus']!=null && deliveryDetail['menus'].isNotEmpty){
      for (var i = 0; i < deliveryDetail['menus'].length; i++) {
        result['menu'][deliveryDetail['menus'][i].name] =
            GlobalKey<ScaffoldState>();
        result['category'][deliveryDetail['menus'][i].name] = {
          'key': GlobalKey<ScaffoldState>(),
          'width': 0.0
        };
      }
    }
    return result;
  }
}
