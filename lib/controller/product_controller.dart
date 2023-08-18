import 'package:get/get.dart';

class ProductController2 extends GetxController {
  var isHeaderFixed = false.obs;
  RxString currentTab = '주문안내'.obs;

  @override
  void onClose() {
    isHeaderFixed.value = false;
    super.onClose();
  }

  var sortValue = 'created_at'.obs;
  var sortDescending = 'DESC'.obs; // ASC: 오름차순, DESC: 내림차순
  var page = 1.obs;

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
}
