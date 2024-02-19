import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:user_core2/controller/user_controller.dart';
import 'package:user_core2/model/wish.dart';
import 'package:user_core2/service/wish_service.dart';
import 'package:user_core2/util/dialog.dart';

class WishScrollController extends GetxController {
  var scrollController = ScrollController().obs;
  var data = <Wish>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  var total = 0.obs;

  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.value.dispose();
    super.onClose();
  }

  void fetch() {
    getData();
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore.value) {
        getData();
      }
    });
  }

  Future<void> getData() async {
    try {
      isLoading.value = true;
      WishResponse response = await WishServices2.getWishes(
          Get.find<UserController>().customer.value!.id, page.value);

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
      showBasicAlertDialog('찜 목록 조회를 실패하였습니다.');
    }
  }

  void initFetchState() {
    isLoading.value = true;
    data.clear();
    hasMore.value = true;
    page.value = 1;
    total.value = 0;
  }

  Future<void> reload() async {
    initFetchState();
    getData();
  }
}
