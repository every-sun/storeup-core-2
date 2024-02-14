import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/wish.dart';
import 'package:user_core2/service/wish_service.dart';
import 'package:user_core2/util/dialog.dart';

class WishController extends GetxController {
  var isLoading = false.obs;
  var isExist = false.obs;

  var scrollController = ScrollController().obs;
  var data = <Wish>[].obs;
  var dataLoading = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  var total = 0.obs;

  @override
  void onInit() {
    _getData();
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore.value) {
        _getData();
      }
    });
    super.onInit();
  }

  Future<void> _getData() async {
    try {
      dataLoading.value = true;
      WishResponse response = await WishServices2.getWishes(
          Get.find<UserController>().customer.value!.id, page.value);
      dataLoading.value = false;

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
      showBasicAlertDialog('찜 목록 조회를 실패하였습니다.');
    }
  }

  void initFetchState() {
    dataLoading.value = true;
    data.clear();
    hasMore.value = true;
    page.value = 1;
    total.value = 0;
  }

  Future<void> reload() async {
    initFetchState();
    _getData();
  }

  /* 찜하기 추가&제거 */
  Future<bool> toggleWish(productId) async {
    if (Get.find<UserController>().customer.value == null) {
      showBasicAlertDialog('로그인이 필요한 서비스입니다.');
      return false;
    }
    try {
      BasicResponse response;
      isLoading.value = true;
      if (isExist.value) {
        response = await WishServices2.deleteWish(
            Get.find<UserController>().customer.value!.id, productId);
      } else {
        response = await WishServices2.storeWish(
            Get.find<UserController>().customer.value!.id, productId);
      }
      isLoading.value = false;
      if (response.status) {
        isExist.value = !isExist.value;
      } else {
        showBasicAlertDialog(response.message);
      }
      return response.status;
    } catch (err) {
      showBasicAlertDialog('찜하기에 실패하였습니다.');
      isLoading.value = false;
      return false;
    }
  }

  /* 상품 상세페이지에서 찜하기 버튼 색깔  */
  Future<void> checkWish(productId) async {
    if (Get.find<UserController>().customer.value == null) {
      isExist.value = false;
    } else {
      try {
        bool value = await WishServices2.checkWish(
            Get.find<UserController>().customer.value!.id, productId);
        isExist.value = value;
      } catch (err) {
        isExist.value = false;
      }
    }
  }
}
