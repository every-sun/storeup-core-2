import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/model/store.dart';
import 'package:user_core2/service/delivery_service.dart';
import 'package:user_core2/service/store_service.dart';
import 'package:user_core2/util/dialog.dart';

class StoreScrollController extends GetxController {
  var data = <Store>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  var total = 0.obs;

  void fetchData(type, groupId, keyword, ScrollController scrollController) {
    reload(type, groupId, keyword);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMore.value) {
        getData(type, groupId, keyword);
      }
    });
  }

  Future<void> getData(type, groupId, keyword) async {
    // type='M', type='DS', type='G', type='SS'
    try {
      isLoading.value = true;

      late StoreResponse response;
      if (type == 'DM') {
        response = await DeliveryServices.getDeliveryStoresRandom(
            Get.find<AppController>().appInfo.value!.brandId, page.value);
      } else if (type == 'DG') {
        response = await DeliveryServices.getDeliveryStoresByGroup(
            Get.find<AppController>().appInfo.value!.brandId,
            groupId,
            page.value);
      } else if (type == 'DS') {
        response = await DeliveryServices.getDeliveryStoresBySearch(
            Get.find<AppController>().appInfo.value!.brandId,
            keyword,
            page.value);
      } else {
        if (keyword != null && keyword != '') {
          response = await StoreServices.getStoresBySearch(
              Get.find<AppController>().appInfo.value!.brandId,
              keyword,
              page.value);
        } else {
          response = await StoreServices.getStores(
              Get.find<AppController>().appInfo.value!.brandId, page.value);
        }
      }

      isLoading.value = false;

      if (response.status &&
          response.data != null &&
          response.data!.data.isNotEmpty) {
        total.value = response.data!.total;
        data.addAll(response.data!.data);
        page.value++;
      }
      if (!response.status) {
        showBasicAlertDialog(response.message);
      }
      if (!response.isDataHasMore) {
        hasMore.value = false;
      }
    } catch (err) {
      initFetchState();
      showBasicAlertDialog('상점 목록 조회를 실패하였습니다.');
    }
  }

  void initFetchState() {
    isLoading.value = false;
    data.clear();
    hasMore.value = true;
    page.value = 1;
    total.value = 0;
  }

  Future<void> reload(type, groupId, keyword) async {
    initFetchState();
    getData(type, groupId, keyword);
  }
}
