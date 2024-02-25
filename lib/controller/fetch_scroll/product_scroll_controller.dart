import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_core2/controller/app_controller.dart';
import 'package:user_core2/model/product.dart';
import 'package:user_core2/model/product_group.dart';
import 'package:user_core2/service/product_service.dart';
import 'package:user_core2/util/dialog.dart';

class ProductScrollController extends GetxController {
  var data = <Product>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  var total = 0.obs;

  var sortValue = 'created_at'.obs;
  var sortDescending = 'DESC'.obs; // ASC: 오름차순, DESC: 내림차순

  var currentGroup = Rxn<ProductGroup>();

  void sortProducts(value) {
    if (value == '최신순') {
      sortValue.value = 'created_at';
      sortDescending.value = 'DESC';
    } else if (value == '상품명순') {
      sortValue.value = 'name';
      sortDescending.value = 'ASC';
    } else if (value == '낮은가격순') {
      sortValue.value = 'price';
      sortDescending.value = 'ASC';
    } else if (value == '높은가격순') {
      sortValue.value = 'price';
      sortDescending.value = 'DESC';
    }
  }

  void fetchData(
      type, id, keyword, ScrollController scrollController, scrollMethod) {
    reload(type, id, keyword);
    scrollController.addListener(() {
      scrollMethod();
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMore.value) {
        getData(type, id, keyword);
      }
    });
  }

  Future<void> getData(type, id, keyword) async {
    // type='G', type='C', type='S', type='SF': 상점별
    try {
      isLoading.value = true;

      late ProductResponse response;
      if (type == 'G') {
        response = await ProductServices2.getProductsByGroup(
            id, sortValue.value, sortDescending.value, page.value);
      } else if (type == 'C') {
        response = await ProductServices2.getProductsByCollection(
            id, sortValue.value, sortDescending.value, page.value);
      } else if (type == 'S') {
        response = await ProductServices2.getProductsBySearch(
            keyword,
            Get.find<AppController>().appInfo.value!.brandId,
            sortValue.value,
            sortDescending.value,
            page.value);
      } else if (type == 'SF') {
        response = await ProductServices2.getProductsByStore(
            Get.find<AppController>().appInfo.value!.brandId,
            id,
            'O',
            sortValue.value,
            sortDescending.value,
            page.value);
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

  Future<void> reload(type, id, keyword) async {
    initFetchState();
    getData(type, id, keyword);
  }
}
