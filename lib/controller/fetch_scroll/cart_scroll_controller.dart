import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/cart.dart';
import 'package:user_core2/model/store.dart';
import 'package:user_core2/service/cart_service.dart';
import 'package:user_core2/service/store_service.dart';
import 'package:user_core2/util/dialog.dart';

class CartScrollController extends GetxController {
  var data = <Cart>[].obs;
  var store = Rxn<Store>();
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  var total = 0.obs;

  Future<dynamic> fetchData(type, ScrollController scrollController) async {
    reload(type);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMore.value) {
        getData(type);
      }
    });
    return null;
  }

  Future<void> getData(type) async {
    // type='D', type='S',
    try {
      isLoading.value = true;

      CartResponse response = await CartServices2.getCarts(
          Get.find<UserController>().customer.value!.id,
          type,
          type == 'D' ? 1 : page.value,
          type == 'D' ? 30 : 16);

      isLoading.value = false;

      if (response.status &&
          response.data != null &&
          response.data!.data.isNotEmpty) {
        if (type == 'D') {
          store.value = await StoreServices2.getStore(
              Get.find<AppController>().appInfo.value!.brandId,
              response.data!.data[0].product.tenantId);
          data.value = response.data!.data;
        } else {
          data.addAll(response.data!.data);
          total.value = response.data!.total;
          page.value++;
        }
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

  Future<void> reload(type) async {
    initFetchState();
    getData(type);
  }
}
